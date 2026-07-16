//! Smoke test: parse every full JSDoc comment block in `test/corpus_smoke/`
//! and require
//! (a) an error-node ratio below 5% per file (with `document` as the root), and
//! (b) the expected top-level node kinds for this grammar across the corpus.
//!
//! jsdoc is an injection grammar (`file-types` is `null` in `tree-sitter.json`):
//! in normal use it is embedded inside JavaScript/TypeScript comments. The smoke
//! corpus therefore parses standalone `/** ... */` comment blocks, delimiters and
//! ` * ` line prefixes included, exactly as the grammar expects them.

use std::fs;
use std::path::PathBuf;

use tree_sitter::{Node, Parser};

const MAX_ERROR_RATIO: f64 = 0.05;

fn count_nodes(node: Node, total: &mut usize, errors: &mut usize) {
    *total += 1;
    if node.is_error() || node.is_missing() {
        *errors += 1;
    }
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        count_nodes(child, total, errors);
    }
}

fn corpus_paths() -> Vec<PathBuf> {
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut paths: Vec<_> = fs::read_dir(&corpus_dir)
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| path.extension().is_some_and(|ext| ext == "jsdoc"))
        .collect();
    paths.sort();
    paths
}

fn new_parser() -> Parser {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_jsdoc::LANGUAGE.into())
        .expect("Error loading JSDoc parser");
    parser
}

#[test]
fn smoke_corpus_parses_cleanly() {
    let paths = corpus_paths();
    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = new_parser();

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser
            .parse(&source, None)
            .unwrap_or_else(|| panic!("parser returned no tree for {}", path.display()));

        let root = tree.root_node();
        assert_eq!(
            root.kind(),
            "document",
            "{}: unexpected root node kind {:?}",
            path.display(),
            root.kind()
        );

        let (mut total, mut errors) = (0usize, 0usize);
        count_nodes(root, &mut total, &mut errors);
        let ratio = errors as f64 / total as f64;
        assert!(
            ratio < MAX_ERROR_RATIO,
            "{}: error-node ratio {:.2}% ({} of {} nodes) exceeds {:.0}%",
            path.display(),
            ratio * 100.0,
            errors,
            total,
            MAX_ERROR_RATIO * 100.0
        );
    }
}

#[test]
fn expected_top_level_node_kinds_are_present() {
    let paths = corpus_paths();
    let mut parser = new_parser();

    let mut seen_tag = false;
    let mut seen_tag_name = false;
    let mut seen_description = false;
    let mut seen_example_body = false;
    let mut seen_type = false;
    let mut seen_code_block = false;

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            match node.kind() {
                "tag" => seen_tag = true,
                "tag_name" => seen_tag_name = true,
                "description" => seen_description = true,
                "example_body" => seen_example_body = true,
                "type" => seen_type = true,
                "code_block" => seen_code_block = true,
                _ => {}
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    assert!(seen_tag, "no `tag` node found anywhere in the corpus");
    assert!(seen_tag_name, "no `tag_name` node found anywhere in the corpus");
    assert!(seen_description, "no `description` node found anywhere in the corpus");
    // `example_body` is the opaque `@example`-body node added by this fork; its
    // presence proves the runnable-code fix is exercised.
    assert!(seen_example_body, "no `example_body` node found anywhere in the corpus");
    assert!(seen_type, "no `type` node found anywhere in the corpus");
    assert!(seen_code_block, "no `code_block` node found anywhere in the corpus");
}
