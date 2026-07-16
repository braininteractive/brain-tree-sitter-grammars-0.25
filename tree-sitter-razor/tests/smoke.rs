//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file (with the root node kind
//!     asserted), and
//! (b) that the expected top-level node kinds for this grammar are present
//!     somewhere across the corpus.
//!
//! The corpus is made of real-shaped `.razor` pages (bare-text pages,
//! `@page`/`@using`/`@inject` directives, `@code` blocks, `@if`/`@foreach`
//! control flow, Razor comments, explicit/implicit expressions and mixed
//! HTML) and every file is expected to parse with zero error/missing nodes.

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
        .filter(|path| path.extension().is_some_and(|ext| ext == "razor"))
        .collect();
    paths.sort();
    paths
}

fn new_parser() -> Parser {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_razor::LANGUAGE.into())
        .expect("Error loading Razor parser");
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
            "compilation_unit",
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
    let paths = corpus_paths();
    let mut parser = new_parser();

    // Meaningful Razor/HTML node kinds this grammar should exercise.
    let expected = [
        "text", // the top-level plain-text node fixed by this fork
        "element",
        "razor_page_directive",
        "razor_using_directive",
        "razor_block",
        "razor_if",
        "razor_foreach",
        "razor_comment",
        "razor_implicit_expression",
        "razor_explicit_expression",
    ];
    let mut seen = std::collections::BTreeSet::new();

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if expected.contains(&node.kind()) {
                seen.insert(node.kind().to_string());
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    for kind in expected {
        assert!(
            seen.contains(kind),
            "expected node kind `{kind}` not found anywhere in the corpus"
        );
    }
}
