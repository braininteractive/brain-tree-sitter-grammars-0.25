#include "tree_sitter/parser.h"

// NOTE: the order of these enum values MUST match the order of the `externals`
// array in grammar.js: [ $.type, $.code_block_line, $.example_body ].
// `code_block_line` is never produced here (it falls back to its grammar rule);
// it exists only to keep the indices aligned with `valid_symbols`.
enum TokenType {
    TYPE_TOKEN,
    CODE_BLOCK_LINE,
    EXAMPLE_BODY,
};

void *tree_sitter_jsdoc_external_scanner_create() { return NULL; }

void tree_sitter_jsdoc_external_scanner_destroy(void *payload) {}

unsigned tree_sitter_jsdoc_external_scanner_serialize(void *payload, char *buffer) { return 0; }

void tree_sitter_jsdoc_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {}

// Scan to the next balanced `}` character.
static bool scan_for_type(TSLexer *lexer) {
    int stack = 0;
    while (true) {
        if (lexer->eof(lexer)) {
            return false;
        }
        switch (lexer->lookahead) {
            case '{':
                stack++;
                break;
            case '}':
                stack--;
                if (stack == -1) {
                    return true;
                }
                break;
            case '\n':
            case '\0': // fallthrough
                // Something's gone wrong.
                return false;
            default:;
        }
        lexer->advance(lexer, false);
    }
}

static bool is_space(int32_t c) { return c == ' ' || c == '\t'; }

// Scan an opaque `@example` body: everything from the current position up to
// (but not including) the closing `*/` or the next `@tag` that starts a logical
// comment line. Line prefixes (` * `) and interior blank lines are tolerated.
//
// Returns false (deferring to the structured `description` rule) when the body
// is empty, immediately hits a new tag / end-of-comment, or begins with a
// fenced code block (a leading backtick) — this preserves upstream parsing of
// ```` ```lang ... ``` ```` code blocks inside `@example`.
static bool scan_example_body(TSLexer *lexer) {
    // Skip leading whitespace, newlines and star prefixes (excluded from the
    // token) to reach the first real content character.
    while (true) {
        if (lexer->eof(lexer)) {
            return false;
        }
        int32_t c = lexer->lookahead;
        if (is_space(c) || c == '\n' || c == '\r') {
            lexer->advance(lexer, true);
            continue;
        }
        if (c == '*') {
            lexer->advance(lexer, true);
            if (lexer->lookahead == '/') {
                return false; // end of comment: empty body
            }
            continue; // a line-prefix star
        }
        break;
    }

    // Defer to the structured rules for empty bodies, a new tag, or a fenced
    // code block.
    if (lexer->lookahead == '@' || lexer->lookahead == '`') {
        return false;
    }

    bool has_content = false;
    while (!lexer->eof(lexer)) {
        int32_t c = lexer->lookahead;

        if (c == '*') {
            lexer->advance(lexer, false);
            if (lexer->lookahead == '/') {
                break; // `*/` closes the comment; excluded from the body
            }
            // An interior star that is part of the body text.
            lexer->mark_end(lexer);
            has_content = true;
            continue;
        }

        if (c == '\n' || c == '\r') {
            // Consume the newline and the next line's prefix without marking the
            // end yet; whether they belong to the body depends on what follows.
            lexer->advance(lexer, false);
            if (c == '\r' && lexer->lookahead == '\n') {
                lexer->advance(lexer, false);
            }
            while (is_space(lexer->lookahead)) {
                lexer->advance(lexer, false);
            }
            bool comment_end = false;
            while (lexer->lookahead == '*') {
                lexer->advance(lexer, false);
                if (lexer->lookahead == '/') {
                    comment_end = true;
                    break;
                }
                while (is_space(lexer->lookahead)) {
                    lexer->advance(lexer, false);
                }
            }
            if (comment_end) {
                break;
            }
            if (lexer->eof(lexer) || lexer->lookahead == '@') {
                break; // next tag / end of comment
            }
            // More body content on this line: loop and let it be consumed. The
            // newline/prefix become interior once the next content char marks
            // the end.
            continue;
        }

        // Ordinary body character.
        lexer->advance(lexer, false);
        lexer->mark_end(lexer);
        has_content = true;
    }

    return has_content;
}

bool tree_sitter_jsdoc_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
    if (valid_symbols[EXAMPLE_BODY] && scan_example_body(lexer)) {
        lexer->result_symbol = EXAMPLE_BODY;
        return true;
    }

    if (valid_symbols[TYPE_TOKEN] && scan_for_type(lexer)) {
        lexer->result_symbol = TYPE_TOKEN;
        lexer->mark_end(lexer);
        return true;
    }

    return false;
}
