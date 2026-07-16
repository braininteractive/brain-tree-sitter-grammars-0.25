//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file (and a `template` root), and
//! (b) the expected top-level node kinds for this grammar to appear somewhere
//!     across the corpus.

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

fn hbs_paths() -> Vec<PathBuf> {
    let mut paths: Vec<_> = fs::read_dir(corpus_dir())
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| path.extension().is_some_and(|ext| ext == "hbs"))
        .collect();
    paths.sort();
    paths
}

#[test]
fn smoke_corpus_parses_cleanly() {
    let paths = hbs_paths();

    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_glimmer::LANGUAGE.into())
        .expect("Error loading Glimmer parser");

    for path in &paths {
        let source = fs::read_to_string(path).unwrap();
        let tree = parser
            .parse(&source, None)
            .unwrap_or_else(|| panic!("parser returned no tree for {}", path.display()));

        let root = tree.root_node();
        assert_eq!(
            root.kind(),
            "template",
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
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_glimmer::LANGUAGE.into())
        .expect("Error loading Glimmer parser");

    let mut seen_element = false;
    let mut seen_void = false;
    let mut seen_mustache = false;
    let mut seen_block = false;
    let mut seen_attribute = false;
    let mut seen_tag_name = false;
    let mut seen_text = false;

    for path in hbs_paths() {
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            match node.kind() {
                "element_node" => seen_element = true,
                "element_node_void" => seen_void = true,
                "mustache_statement" => seen_mustache = true,
                "block_statement" => seen_block = true,
                "attribute_node" => seen_attribute = true,
                "tag_name" => seen_tag_name = true,
                "text_node" => seen_text = true,
                _ => {}
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    assert!(seen_element, "no `element_node` node found in the corpus");
    assert!(
        seen_void,
        "no `element_node_void` node found in the corpus (void-element fix regressed?)"
    );
    assert!(
        seen_mustache,
        "no `mustache_statement` node found in the corpus"
    );
    assert!(seen_block, "no `block_statement` node found in the corpus");
    assert!(
        seen_attribute,
        "no `attribute_node` node found in the corpus"
    );
    assert!(seen_tag_name, "no `tag_name` node found in the corpus");
    assert!(seen_text, "no `text_node` node found in the corpus");
}

/// Directly guard the void-element fix: bare HTML void elements must parse with
/// zero error nodes, matching the self-closed forms.
#[test]
fn bare_void_elements_have_no_errors() {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_glimmer::LANGUAGE.into())
        .expect("Error loading Glimmer parser");

    for snippet in [
        "<input type=\"text\">",
        "<br>",
        "<img src=\"x\">",
        "<hr>",
        "<meta charset=\"utf-8\">",
        "<link rel=\"stylesheet\" href=\"/a.css\">",
        // self-closed and paired forms must still be clean
        "<br />",
        "<img src=\"x\" />",
        "<div>hi</div>",
        // a custom element whose name merely starts with a void name is NOT void
        "<input-group>x</input-group>",
    ] {
        let tree = parser.parse(snippet, None).unwrap();
        assert!(
            !tree.root_node().has_error(),
            "snippet unexpectedly produced errors: {snippet:?}"
        );
    }
}
