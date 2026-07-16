//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file, and
//! (b) the expected top-level node kinds for this grammar.
//!
//! Constructs that the grammar does not support yet live in
//! `test/corpus_known_gaps/` and are deliberately NOT parsed here.

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

#[test]
fn smoke_corpus_parses_cleanly() {
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut paths: Vec<_> = fs::read_dir(&corpus_dir)
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| path.extension().is_some_and(|ext| ext == "sql"))
        .collect();
    paths.sort();

    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_tsql::LANGUAGE.into())
        .expect("Error loading TSQL parser");

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser
            .parse(&source, None)
            .unwrap_or_else(|| panic!("parser returned no tree for {}", path.display()));

        let root = tree.root_node();
        assert_eq!(
            root.kind(),
            "tsql_file",
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
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_tsql::LANGUAGE.into())
        .expect("Error loading TSQL parser");

    const EXPECTED_KINDS: &[&str] = &[
        "select_statement",
        "insert_statement",
        "update_statement",
        "delete_statement",
        "merge_statement",
        "create_table",
        "create_procedure",
        "if_statement",
        "while_statement",
        "try_catch_statement",
        "declare_statement",
        "go_statement",
        "join_on",
        "where_clause",
        "binary_expression",
        "comment",
    ];
    let mut seen = vec![false; EXPECTED_KINDS.len()];

    for entry in fs::read_dir(&corpus_dir).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().is_none_or(|ext| ext != "sql") {
            continue;
        }
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if let Some(idx) = EXPECTED_KINDS.iter().position(|k| *k == node.kind()) {
                seen[idx] = true;
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    for (idx, kind) in EXPECTED_KINDS.iter().enumerate() {
        assert!(seen[idx], "no `{kind}` node found anywhere in the corpus");
    }
}
