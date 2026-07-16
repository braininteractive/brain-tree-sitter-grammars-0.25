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

#[test]
fn smoke_corpus_parses_cleanly() {
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut paths: Vec<_> = fs::read_dir(&corpus_dir)
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| path.extension().is_some_and(|ext| ext == "rst"))
        .collect();
    paths.sort();

    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rst::LANGUAGE.into())
        .expect("Error loading ReStructuredText parser");

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
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rst::LANGUAGE.into())
        .expect("Error loading ReStructuredText parser");

    let mut seen_section = false;
    let mut seen_title = false;
    let mut seen_directive = false;
    let mut seen_role = false;
    let mut seen_literal_block = false;
    let mut seen_field_list = false;
    let mut seen_bullet_list = false;
    let mut seen_enumerated_list = false;
    let mut seen_target = false;
    let mut seen_footnote = false;

    for entry in fs::read_dir(&corpus_dir).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().is_none_or(|ext| ext != "rst") {
            continue;
        }
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            match node.kind() {
                "section" => seen_section = true,
                "title" => seen_title = true,
                "directive" => seen_directive = true,
                "role" => seen_role = true,
                "literal_block" => seen_literal_block = true,
                "field_list" => seen_field_list = true,
                "bullet_list" => seen_bullet_list = true,
                "enumerated_list" => seen_enumerated_list = true,
                "target" => seen_target = true,
                "footnote" => seen_footnote = true,
                _ => {}
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    assert!(seen_section, "no `section` node found anywhere in the corpus");
    assert!(seen_title, "no `title` node found anywhere in the corpus");
    assert!(
        seen_directive,
        "no `directive` node found anywhere in the corpus"
    );
    assert!(seen_role, "no `role` node found anywhere in the corpus");
    assert!(
        seen_literal_block,
        "no `literal_block` node found anywhere in the corpus"
    );
    assert!(
        seen_field_list,
        "no `field_list` node found anywhere in the corpus"
    );
    assert!(
        seen_bullet_list,
        "no `bullet_list` node found anywhere in the corpus"
    );
    assert!(
        seen_enumerated_list,
        "no `enumerated_list` node found anywhere in the corpus"
    );
    assert!(seen_target, "no `target` node found anywhere in the corpus");
    assert!(
        seen_footnote,
        "no `footnote` node found anywhere in the corpus"
    );
}
