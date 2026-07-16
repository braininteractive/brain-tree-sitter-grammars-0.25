//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file, and
//! (b) the expected node kinds for this grammar.

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
        .filter(|path| path.extension().is_some_and(|ext| ext == "jinja"))
        .collect();
    paths.sort();

    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_jinja::LANGUAGE.into())
        .expect("Error loading Jinja parser");

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser
            .parse(&source, None)
            .unwrap_or_else(|| panic!("parser returned no tree for {}", path.display()));

        let root = tree.root_node();
        assert_eq!(
            root.kind(),
            "source",
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
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_jinja::LANGUAGE.into())
        .expect("Error loading Jinja parser");

    let expected = [
        "statement",         // {% extends %}, {% include %}, {% import %}, {% set %}, {% do %}
        "render_expression", // {{ ... }}
        "comment",           // {# ... #} and ## line comments
        "if_block",
        "for_block",
        "block_block",
        "macro_block",
        "call_block",
        "filter_block",
        "set_block",
        "with_block",
        "trans_block",
        "autoescape_block",
        "raw_block",
        "function_call",
        "binary_expression",
    ];
    let mut seen: std::collections::HashSet<&str> = std::collections::HashSet::new();

    for entry in fs::read_dir(&corpus_dir).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().is_none_or(|ext| ext != "jinja") {
            continue;
        }
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if let Some(kind) = expected.iter().find(|k| **k == node.kind()) {
                seen.insert(kind);
            }
            let mut cursor = node.walk();
            for child in node.children(&mut cursor) {
                stack.push(child);
            }
            drop(cursor);
        }
    }

    for kind in expected {
        assert!(
            seen.contains(kind),
            "expected node kind {kind:?} was never produced by the smoke corpus"
        );
    }
}
