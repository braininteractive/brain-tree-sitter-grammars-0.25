#include "tree_sitter/parser.h"

#include <stdint.h>
#include <stdlib.h>

// External scanner for NEON indentation.
//
// Emits three tokens:
//   NEWLINE  - line break between siblings at the same indent level
//   INDENT   - a deeper-indented block opens
//   DEDENT   - a block closes (one per level unwound)
//
// Blank lines and comment-only lines are skipped while looking ahead to the
// next line's indentation, so they never produce spurious tokens.

enum TokenType {
  NEWLINE,
  INDENT,
  DEDENT,
};

typedef struct {
  uint32_t size;
  uint32_t capacity;
  uint16_t *data;
} Indents;

static void indents_push(Indents *v, uint16_t value) {
  if (v->size == v->capacity) {
    v->capacity = v->capacity ? v->capacity * 2 : 8;
    v->data = realloc(v->data, v->capacity * sizeof(uint16_t));
  }
  v->data[v->size++] = value;
}

typedef struct {
  Indents indents;
  // When dedenting multiple levels we may need several scan() calls without an
  // intervening newline. `pending` remembers the measured indent of the line
  // we are unwinding toward; `has_pending` marks that we are mid-unwind.
  uint16_t pending;
  bool has_pending;
} Scanner;

void *tree_sitter_neon_external_scanner_create(void) {
  Scanner *s = calloc(1, sizeof(Scanner));
  indents_push(&s->indents, 0);
  return s;
}

void tree_sitter_neon_external_scanner_destroy(void *payload) {
  Scanner *s = payload;
  free(s->indents.data);
  free(s);
}

unsigned tree_sitter_neon_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *s = payload;
  unsigned size = 0;
  buffer[size++] = s->has_pending ? 1 : 0;
  buffer[size++] = s->pending & 0xFF;
  buffer[size++] = (s->pending >> 8) & 0xFF;
  for (uint32_t i = 0; i < s->indents.size; i++) {
    if (size + 2 > TREE_SITTER_SERIALIZATION_BUFFER_SIZE) break;
    buffer[size++] = s->indents.data[i] & 0xFF;
    buffer[size++] = (s->indents.data[i] >> 8) & 0xFF;
  }
  return size;
}

void tree_sitter_neon_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
  Scanner *s = payload;
  s->indents.size = 0;
  s->has_pending = false;
  s->pending = 0;
  if (length == 0) {
    indents_push(&s->indents, 0);
    return;
  }
  unsigned i = 0;
  s->has_pending = buffer[i++] != 0;
  s->pending = (uint8_t)buffer[i] | ((uint8_t)buffer[i + 1] << 8);
  i += 2;
  for (; i + 1 < length; i += 2) {
    indents_push(&s->indents, (uint8_t)buffer[i] | ((uint8_t)buffer[i + 1] << 8));
  }
  if (s->indents.size == 0) indents_push(&s->indents, 0);
}

static void skip(TSLexer *lexer) { lexer->advance(lexer, true); }

bool tree_sitter_neon_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  Scanner *s = payload;
  uint16_t top = s->indents.data[s->indents.size - 1];

  // Continue an in-progress multi-level dedent.
  if (s->has_pending) {
    if (s->pending < top && valid_symbols[DEDENT]) {
      s->indents.size--;
      lexer->result_symbol = DEDENT;
      return true;
    }
    s->has_pending = false;
    if (s->pending == top && valid_symbols[NEWLINE]) {
      lexer->result_symbol = NEWLINE;
      return true;
    }
    return false;
  }

  // At end of file, unwind any open blocks.
  if (lexer->eof(lexer)) {
    if (valid_symbols[DEDENT] && s->indents.size > 1) {
      s->indents.size--;
      lexer->result_symbol = DEDENT;
      return true;
    }
    return false;
  }

  bool saw_newline = false;
  uint16_t indent = 0;

  for (;;) {
    if (lexer->lookahead == '\n') {
      saw_newline = true;
      indent = 0;
      skip(lexer);
    } else if (lexer->lookahead == '\r') {
      skip(lexer);
    } else if (lexer->lookahead == ' ' || lexer->lookahead == '\t') {
      indent++;
      skip(lexer);
    } else if (lexer->lookahead == '#') {
      // Stop at a comment without consuming it, so the grammar tokenizes it as
      // a `comment` extra (and it gets highlighted). The indentation measured
      // up to here is used for the structural token, so a comment aligned with
      // its surrounding block stays transparent to nesting.
      break;
    } else {
      break;
    }
  }

  if (!saw_newline) return false;

  // Trailing newline(s) at EOF. Unwind open blocks first; once at the base
  // level emit a NEWLINE so the document's trailing separator consumes the
  // final line break (the dead "expect another pair" parse is discarded).
  if (lexer->eof(lexer)) {
    if (valid_symbols[DEDENT] && s->indents.size > 1) {
      s->indents.size--;
      lexer->result_symbol = DEDENT;
      return true;
    }
    if (valid_symbols[NEWLINE]) {
      lexer->result_symbol = NEWLINE;
      return true;
    }
    return false;
  }

  // The token carries no characters; it sits at the first real character of
  // the next line.
  lexer->mark_end(lexer);

  if (indent > top) {
    if (valid_symbols[INDENT]) {
      indents_push(&s->indents, indent);
      lexer->result_symbol = INDENT;
      return true;
    }
  } else if (indent < top) {
    if (valid_symbols[DEDENT]) {
      s->pending = indent;
      s->has_pending = true;
      s->indents.size--;
      lexer->result_symbol = DEDENT;
      return true;
    }
  }

  if (valid_symbols[NEWLINE]) {
    lexer->result_symbol = NEWLINE;
    return true;
  }

  return false;
}
