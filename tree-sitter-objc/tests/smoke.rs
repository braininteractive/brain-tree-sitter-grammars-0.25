//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error/missing-node ratio below 5% per file (with the expected
//!     `translation_unit` root), and
//! (b) that the top-level node kinds meaningful for Objective-C — including
//!     the `nullability_region` and `attribute_macro` nodes this fork adds —
//!     are present somewhere across the corpus.

use std::fs;
use std::path::PathBuf;

use tree_sitter::{Node, Parser};

const MAX_ERROR_RATIO: f64 = 0.05;

fn is_objc_source(path: &PathBuf) -> bool {
    path.extension()
        .is_some_and(|ext| ext == "h" || ext == "m")
}

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
        .filter(is_objc_source)
        .collect();
    paths.sort();
    paths
}

fn new_parser() -> Parser {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_objc::LANGUAGE.into())
        .expect("Error loading Objective-C parser");
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
            "translation_unit",
            "{}: unexpected root node kind {:?}",
            path.display(),
            root.kind()
        );

        let (mut total, mut errors) = (0usize, 0usize);
        count_nodes(root, &mut total, &mut errors);
        let ratio = errors as f64 / total as f64;
        assert!(
            ratio < MAX_ERROR_RATIO,
            "{}: error/missing-node ratio {:.2}% ({} of {} nodes) exceeds {:.0}%",
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
    let mut parser = new_parser();

    // Kinds meaningful for Objective-C headers/implementations. The last two
    // are the nodes this fork introduces to stop nullability-region and
    // availability-macro constructs from cascading into ERRORs.
    let wanted = [
        "class_interface",
        "class_implementation",
        "protocol_declaration",
        "class_declaration",
        "property_declaration",
        "method_declaration",
        "nullability_region",
        "attribute_macro",
    ];
    let mut seen = [false; 8];

    for path in corpus_paths() {
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if let Some(idx) = wanted.iter().position(|k| *k == node.kind()) {
                seen[idx] = true;
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    for (kind, found) in wanted.iter().zip(seen.iter()) {
        assert!(found, "no `{kind}` node found anywhere in the corpus");
    }
}
