/* C port of the original scanner.cc (kept verbatim in git history).
 * Ported so the tree-sitter CLI (>= 0.22), which cannot load C++
 * scanners, can load this grammar; logic is a faithful translation. */
#include "tree_sitter/parser.h"
#include "tree_sitter/alloc.h"
#include "tree_sitter/array.h"

#include <string.h>

enum TokenType {
  NEWLINE,
  INDENT,
  DEDENT,
  STRING_START,
  STRING_CONTENT,
  STRING_END,
  COMMENT,
  CLOSE_PAREN,
  CLOSE_BRACKET,
  CLOSE_BRACE,
};

enum DelimiterFlags {
  SingleQuote = 1 << 0,
  DoubleQuote = 1 << 1,
  BackQuote = 1 << 2,
  Raw = 1 << 3,
  Format = 1 << 4,
  Triple = 1 << 5,
  Bytes = 1 << 6,
};

typedef char Delimiter;

static inline bool delimiter_is_format(Delimiter d) { return d & Format; }
static inline bool delimiter_is_raw(Delimiter d) { return d & Raw; }
static inline bool delimiter_is_triple(Delimiter d) { return d & Triple; }
static inline bool delimiter_is_bytes(Delimiter d) { return d & Bytes; }

static inline int32_t delimiter_end_character(Delimiter d) {
  if (d & SingleQuote) return '\'';
  if (d & DoubleQuote) return '"';
  if (d & BackQuote) return '`';
  return 0;
}

static inline void delimiter_set_end_character(Delimiter *d, int32_t character) {
  switch (character) {
    case '\'': *d |= SingleQuote; break;
    case '"': *d |= DoubleQuote; break;
    case '`': *d |= BackQuote; break;
    default: break;
  }
}

typedef struct {
  Array(uint16_t) indent_length_stack;
  Array(Delimiter) delimiter_stack;
} Scanner;

static inline void advance(TSLexer *lexer) { lexer->advance(lexer, false); }
static inline void skip(TSLexer *lexer) { lexer->advance(lexer, true); }

bool tree_sitter_vyper_external_scanner_scan(void *payload, TSLexer *lexer,
                                             const bool *valid_symbols) {
  Scanner *scanner = (Scanner *)payload;

  bool error_recovery_mode = valid_symbols[STRING_CONTENT] && valid_symbols[INDENT];
  bool within_brackets =
      valid_symbols[CLOSE_BRACE] || valid_symbols[CLOSE_PAREN] || valid_symbols[CLOSE_BRACKET];

  if (valid_symbols[STRING_CONTENT] && scanner->delimiter_stack.size > 0 &&
      !error_recovery_mode) {
    Delimiter delimiter = *array_back(&scanner->delimiter_stack);
    int32_t end_character = delimiter_end_character(delimiter);
    bool has_content = false;
    while (lexer->lookahead) {
      if ((lexer->lookahead == '{' || lexer->lookahead == '}') &&
          delimiter_is_format(delimiter)) {
        lexer->mark_end(lexer);
        lexer->result_symbol = STRING_CONTENT;
        return has_content;
      }
      if (lexer->lookahead == '\\') {
        if (delimiter_is_raw(delimiter)) {
          lexer->advance(lexer, false);
        } else if (delimiter_is_bytes(delimiter)) {
          lexer->mark_end(lexer);
          lexer->advance(lexer, false);
          if (lexer->lookahead == 'N' || lexer->lookahead == 'u' ||
              lexer->lookahead == 'U') {
            /* In bytes strings, \N{...}, \uXXXX and \UXXXXXXXX are not
             * escape sequences. */
            lexer->advance(lexer, false);
          } else {
            lexer->result_symbol = STRING_CONTENT;
            return has_content;
          }
        } else {
          lexer->mark_end(lexer);
          lexer->result_symbol = STRING_CONTENT;
          return has_content;
        }
      } else if (lexer->lookahead == end_character) {
        if (delimiter_is_triple(delimiter)) {
          lexer->mark_end(lexer);
          lexer->advance(lexer, false);
          if (lexer->lookahead == end_character) {
            lexer->advance(lexer, false);
            if (lexer->lookahead == end_character) {
              if (has_content) {
                lexer->result_symbol = STRING_CONTENT;
              } else {
                lexer->advance(lexer, false);
                lexer->mark_end(lexer);
                (void)array_pop(&scanner->delimiter_stack);
                lexer->result_symbol = STRING_END;
              }
              return true;
            }
            lexer->mark_end(lexer);
            lexer->result_symbol = STRING_CONTENT;
            return true;
          }
          lexer->mark_end(lexer);
          lexer->result_symbol = STRING_CONTENT;
          return true;
        }
        if (has_content) {
          lexer->result_symbol = STRING_CONTENT;
        } else {
          lexer->advance(lexer, false);
          (void)array_pop(&scanner->delimiter_stack);
          lexer->result_symbol = STRING_END;
        }
        lexer->mark_end(lexer);
        return true;
      } else if (lexer->lookahead == '\n' && has_content &&
                 !delimiter_is_triple(delimiter)) {
        return false;
      }
      advance(lexer);
      has_content = true;
    }
  }

  lexer->mark_end(lexer);

  bool found_end_of_line = false;
  uint32_t indent_length = 0;
  int32_t first_comment_indent_length = -1;
  for (;;) {
    if (lexer->lookahead == '\n') {
      found_end_of_line = true;
      indent_length = 0;
      skip(lexer);
    } else if (lexer->lookahead == ' ') {
      indent_length++;
      skip(lexer);
    } else if (lexer->lookahead == '\r') {
      indent_length = 0;
      skip(lexer);
    } else if (lexer->lookahead == '\t') {
      indent_length += 8;
      skip(lexer);
    } else if (lexer->lookahead == '#') {
      if (first_comment_indent_length == -1) {
        first_comment_indent_length = (int32_t)indent_length;
      }
      while (lexer->lookahead && lexer->lookahead != '\n') {
        skip(lexer);
      }
      skip(lexer);
      indent_length = 0;
    } else if (lexer->lookahead == '\\') {
      skip(lexer);
      if (lexer->lookahead == '\r') {
        skip(lexer);
      }
      if (lexer->lookahead == '\n') {
        skip(lexer);
      } else {
        return false;
      }
    } else if (lexer->lookahead == '\f') {
      indent_length = 0;
      skip(lexer);
    } else if (lexer->lookahead == 0) {
      indent_length = 0;
      found_end_of_line = true;
      break;
    } else {
      break;
    }
  }

  if (found_end_of_line) {
    if (scanner->indent_length_stack.size > 0) {
      uint16_t current_indent_length = *array_back(&scanner->indent_length_stack);

      if (valid_symbols[INDENT] && indent_length > current_indent_length) {
        array_push(&scanner->indent_length_stack, indent_length);
        lexer->result_symbol = INDENT;
        return true;
      }

      if ((valid_symbols[DEDENT] || (!valid_symbols[NEWLINE] && !within_brackets)) &&
          indent_length < current_indent_length &&
          /* Wait to create a dedent token until we've consumed any
           * comments whose indentation matches the current block. */
          first_comment_indent_length < (int32_t)current_indent_length) {
        (void)array_pop(&scanner->indent_length_stack);
        lexer->result_symbol = DEDENT;
        return true;
      }
    }

    if (valid_symbols[NEWLINE] && !error_recovery_mode) {
      lexer->result_symbol = NEWLINE;
      return true;
    }
  }

  if (first_comment_indent_length == -1 && valid_symbols[STRING_START]) {
    Delimiter delimiter = 0;

    bool has_flags = false;
    while (lexer->lookahead) {
      if (lexer->lookahead == 'f' || lexer->lookahead == 'F') {
        delimiter |= Format;
      } else if (lexer->lookahead == 'r' || lexer->lookahead == 'R') {
        delimiter |= Raw;
      } else if (lexer->lookahead == 'b' || lexer->lookahead == 'B') {
        delimiter |= Bytes;
      } else if (lexer->lookahead != 'u' && lexer->lookahead != 'U') {
        break;
      }
      has_flags = true;
      advance(lexer);
    }

    if (lexer->lookahead == '`') {
      delimiter_set_end_character(&delimiter, '`');
      advance(lexer);
      lexer->mark_end(lexer);
    } else if (lexer->lookahead == '\'') {
      delimiter_set_end_character(&delimiter, '\'');
      advance(lexer);
      lexer->mark_end(lexer);
      if (lexer->lookahead == '\'') {
        advance(lexer);
        if (lexer->lookahead == '\'') {
          advance(lexer);
          lexer->mark_end(lexer);
          delimiter |= Triple;
        }
      }
    } else if (lexer->lookahead == '"') {
      delimiter_set_end_character(&delimiter, '"');
      advance(lexer);
      lexer->mark_end(lexer);
      if (lexer->lookahead == '"') {
        advance(lexer);
        if (lexer->lookahead == '"') {
          advance(lexer);
          lexer->mark_end(lexer);
          delimiter |= Triple;
        }
      }
    }

    if (delimiter_end_character(delimiter)) {
      array_push(&scanner->delimiter_stack, delimiter);
      lexer->result_symbol = STRING_START;
      return true;
    }
    if (has_flags) {
      return false;
    }
  }

  return false;
}

unsigned tree_sitter_vyper_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *scanner = (Scanner *)payload;
  size_t i = 0;

  size_t delimiter_count = scanner->delimiter_stack.size;
  if (delimiter_count > UINT8_MAX) delimiter_count = UINT8_MAX;
  buffer[i++] = (char)delimiter_count;

  if (delimiter_count > 0) {
    memcpy(&buffer[i], scanner->delimiter_stack.contents, delimiter_count);
  }
  i += delimiter_count;

  for (uint32_t j = 1;
       j < scanner->indent_length_stack.size && i < TREE_SITTER_SERIALIZATION_BUFFER_SIZE;
       j++) {
    buffer[i++] = (char)*array_get(&scanner->indent_length_stack, j);
  }

  return (unsigned)i;
}

void tree_sitter_vyper_external_scanner_deserialize(void *payload, const char *buffer,
                                                    unsigned length) {
  Scanner *scanner = (Scanner *)payload;
  array_clear(&scanner->delimiter_stack);
  array_clear(&scanner->indent_length_stack);
  array_push(&scanner->indent_length_stack, 0);

  if (length > 0) {
    size_t i = 0;

    size_t delimiter_count = (uint8_t)buffer[i++];
    if (delimiter_count > 0) {
      array_reserve(&scanner->delimiter_stack, (uint32_t)delimiter_count);
      scanner->delimiter_stack.size = (uint32_t)delimiter_count;
      memcpy(scanner->delimiter_stack.contents, &buffer[i], delimiter_count);
    }
    i += delimiter_count;

    for (; i < length; i++) {
      array_push(&scanner->indent_length_stack, (uint16_t)(uint8_t)buffer[i]);
    }
  }
}

void *tree_sitter_vyper_external_scanner_create(void) {
  Scanner *scanner = ts_calloc(1, sizeof(Scanner));
  array_init(&scanner->indent_length_stack);
  array_init(&scanner->delimiter_stack);
  tree_sitter_vyper_external_scanner_deserialize(scanner, NULL, 0);
  return scanner;
}

void tree_sitter_vyper_external_scanner_destroy(void *payload) {
  Scanner *scanner = (Scanner *)payload;
  array_delete(&scanner->indent_length_stack);
  array_delete(&scanner->delimiter_stack);
  ts_free(scanner);
}
