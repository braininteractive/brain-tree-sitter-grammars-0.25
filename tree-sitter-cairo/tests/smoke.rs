//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file, and
//! (b) the expected top-level node kinds for this grammar.

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
    let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut paths: Vec<_> = fs::read_dir(&dir)
        .expect("test/corpus_smoke directory is missing")
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|x| x == "cairo"))
        .collect();
    paths.sort();
    paths
}

fn make_parser() -> Parser {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_cairo::LANGUAGE.into())
        .expect("Error loading Cairo parser");
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

    let mut parser = make_parser();
    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser
            .parse(&source, None)
            .unwrap_or_else(|| panic!("parser returned no tree for {}", path.display()));

        let root = tree.root_node();
        assert_eq!(
            root.kind(),
            "source_file",
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
fn expected_node_kinds_are_present() {
    let expected = [
        "function_item",
        "struct_item",
        "enum_item",
        "trait_item",
        "impl_item",
        "mod_item",
        "match_expression",
    ];
    let mut seen: std::collections::HashSet<&str> = std::collections::HashSet::new();

    let mut parser = make_parser();
    for path in corpus_paths() {
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();
        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if let Some(k) = expected.iter().find(|k| **k == node.kind()) {
                seen.insert(k);
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }
    assert!(
        !seen.is_empty(),
        "none of the expected node kinds {:?} were found; corpus may not match grammar kind names",
        expected
    );
}
