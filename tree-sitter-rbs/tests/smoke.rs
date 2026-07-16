//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file (asserting the root node kind),
//! and (b) the expected top-level node kinds for this grammar, including the
//! nodes introduced/repaired by this fork (method-level `generics_bound` and
//! bang method names).

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

fn corpus_dir() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke")
}

fn new_parser() -> Parser {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rbs::LANGUAGE.into())
        .expect("Error loading rbs parser");
    parser
}

#[test]
fn smoke_corpus_parses_cleanly() {
    let mut paths: Vec<_> = fs::read_dir(corpus_dir())
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| path.extension().is_some_and(|ext| ext == "rbs"))
        .collect();
    paths.sort();

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
            "program",
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
    let mut parser = new_parser();

    // Kinds that should appear somewhere across the corpus. `generics_bound`
    // and `identifier_bang` in particular exercise the fixes in this fork.
    let expected = [
        "class_decl",
        "module_decl",
        "interface_decl",
        "method_member",
        "attribute_member",
        "type_alias_decl",
        "const_decl",
        "annotation",
        "method_type_parameters",
        "generics_bound",
        "identifier_bang",
    ];
    let mut seen = std::collections::BTreeSet::new();

    for entry in fs::read_dir(corpus_dir()).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().is_none_or(|ext| ext != "rbs") {
            continue;
        }
        let source = fs::read_to_string(&path).unwrap();
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
            "expected to find a `{kind}` node somewhere in the corpus"
        );
    }
}
