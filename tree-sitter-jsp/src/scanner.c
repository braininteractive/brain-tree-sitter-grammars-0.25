// External scanner for tree-sitter-jsp.
// Handles JSP comment content: everything between <%-- and --%>.

#include "tree_sitter/parser.h"

enum TokenType {
    COMMENT_CONTENT,
};

void *tree_sitter_jsp_external_scanner_create(void) { return NULL; }
void tree_sitter_jsp_external_scanner_destroy(void *payload) {}
unsigned tree_sitter_jsp_external_scanner_serialize(void *payload, char *buffer) { return 0; }
void tree_sitter_jsp_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {}

bool tree_sitter_jsp_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
    if (!valid_symbols[COMMENT_CONTENT]) return false;

    bool has_content = false;

    while (lexer->lookahead != 0) {
        // Check for the end delimiter --%>
        if (lexer->lookahead == '-') {
            lexer->mark_end(lexer);

            lexer->advance(lexer, false);  // consume first '-'
            if (lexer->lookahead == '-') {
                lexer->advance(lexer, false);  // consume second '-'
                if (lexer->lookahead == '%') {
                    lexer->advance(lexer, false);  // consume '%'
                    if (lexer->lookahead == '>') {
                        // Found --%> — don't consume it; mark_end was set before
                        lexer->result_symbol = COMMENT_CONTENT;
                        return has_content;
                    }
                }
            }
            has_content = true;
        } else {
            has_content = true;
            lexer->advance(lexer, false);
        }
    }

    // EOF reached without finding --%>
    if (has_content) {
        lexer->mark_end(lexer);
        lexer->result_symbol = COMMENT_CONTENT;
        return true;
    }
    return false;
}
