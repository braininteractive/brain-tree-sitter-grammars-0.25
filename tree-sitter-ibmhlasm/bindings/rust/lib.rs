//! This crate provides IBM HLASM (High Level Assembler) language support for
//! the [tree-sitter][] parsing library.
//!
//! Typically, you will use the [LANGUAGE][] constant to add this language to a
//! tree-sitter [Parser][], and then use the parser to parse some code:
//!
//! ```
//! // Notes: HLASM is column-sensitive, so the sample is built with explicit
//! // newlines (Rust's `\`-continuation would strip the leading blanks), and
//! // the source must not end with a trailing newline (an upstream grammar
//! // quirk inserts a zero-width MISSING `_newline` node at EOF otherwise).
//! let code = concat!(
//!     "* A tiny HLASM sample\n",
//!     "HELLO    CSECT\n",
//!     "         LR    12,15\n",
//!     "         END   HELLO",
//! );
//! let mut parser = tree_sitter::Parser::new();
//! let language = tree_sitter_ibmhlasm::LANGUAGE;
//! parser
//!     .set_language(&language.into())
//!     .expect("Error loading ibmhlasm parser");
//! let tree = parser.parse(code, None).unwrap();
//! assert!(!tree.root_node().has_error());
//! ```
//!
//! [Parser]: https://docs.rs/tree-sitter/*/tree_sitter/struct.Parser.html
//! [tree-sitter]: https://tree-sitter.github.io/

use tree_sitter_language::LanguageFn;

extern "C" {
    fn tree_sitter_ibmhlasm() -> *const ();
}

/// The tree-sitter [`LanguageFn`][LanguageFn] for this grammar.
///
/// [LanguageFn]: https://docs.rs/tree-sitter-language/*/tree_sitter_language/struct.LanguageFn.html
pub const LANGUAGE: LanguageFn = unsafe { LanguageFn::from_raw(tree_sitter_ibmhlasm) };

/// The content of the [`node-types.json`][] file for this grammar.
///
/// [`node-types.json`]: https://tree-sitter.github.io/tree-sitter/using-parsers#static-node-types
pub const NODE_TYPES: &str = include_str!("../../src/node-types.json");

#[cfg(test)]
mod tests {
    #[test]
    fn test_can_load_grammar() {
        let mut parser = tree_sitter::Parser::new();
        parser
            .set_language(&super::LANGUAGE.into())
            .expect("Error loading ibmhlasm parser");
    }
}
