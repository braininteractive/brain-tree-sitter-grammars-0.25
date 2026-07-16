//! Smoke test: parse every file in `test/corpus_smoke/` and require
//! (a) an error-node ratio below 5% per file, and
//! (b) the expected reader-syntax node kinds for this grammar.

use std::fs;
use std::path::PathBuf;

use tree_sitter::{Node, Parser};

const MAX_ERROR_RATIO: f64 = 0.05;

fn corpus_paths() -> Vec<PathBuf> {
    let corpus_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/corpus_smoke");
    let mut paths: Vec<_> = fs::read_dir(&corpus_dir)
        .expect("test/corpus_smoke directory is missing")
        .map(|entry| entry.unwrap().path())
        .filter(|path| {
            path.extension()
                .is_some_and(|ext| ext == "clj" || ext == "cljc" || ext == "cljs")
        })
        .collect();
    paths.sort();
    paths
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

#[test]
fn smoke_corpus_parses_cleanly() {
    let paths = corpus_paths();
    assert!(
        paths.len() >= 10,
        "expected at least 10 corpus files, found {}",
        paths.len()
    );

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_clojure::LANGUAGE.into())
        .expect("Error loading Clojure parser");

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
fn expected_reader_syntax_node_kinds_are_present() {
    // Full reader-level surface of Clojure that this grammar intentionally
    // targets (forms, not macro semantics).
    let expected = [
        "list_lit",
        "vec_lit",
        "map_lit",
        "set_lit",
        "kwd_lit",
        "str_lit",
        "num_lit",
        "char_lit",
        "sym_lit",
        "quoting_lit",
        "syn_quoting_lit",
        "unquoting_lit",
        "unquote_splicing_lit",
        "read_cond_lit",
        "splicing_read_cond_lit",
        "tagged_or_ctor_lit",
        "meta_lit",
        "old_meta_lit",
        "anon_fn_lit",
        "regex_lit",
        "var_quoting_lit",
        "derefing_lit",
        "ns_map_lit",
        "sym_val_lit",
        "dis_expr",
        "comment",
    ];
    let mut seen = vec![false; expected.len()];

    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_clojure::LANGUAGE.into())
        .expect("Error loading Clojure parser");

    for path in corpus_paths() {
        let source = fs::read_to_string(&path).unwrap();
        let tree = parser.parse(&source, None).unwrap();

        let mut stack = vec![tree.root_node()];
        while let Some(node) = stack.pop() {
            if let Some(pos) = expected.iter().position(|kind| *kind == node.kind()) {
                seen[pos] = true;
            }
            let mut cursor = node.walk();
            stack.extend(node.children(&mut cursor));
        }
    }

    for (kind, seen) in expected.iter().zip(seen) {
        assert!(seen, "no `{kind}` node found anywhere in the corpus");
    }
}
