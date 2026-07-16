# tree-sitter-json5

[JSON5](https://json5.org) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## Provenance

- **Upstream:** <https://github.com/Joakker/tree-sitter-json5> (fork of commit `248b856`, 2026-05-04)
- **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language` `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved from a hard dependency to a dev-dependency; `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); added a smoke-test corpus (`test/corpus_smoke/`, synthetic samples) and `tests/smoke.rs`. No grammar-rule changes.
- **Rebase policy:** binding-only diff — this fork is rebased onto upstream whenever upstream moves, and retired if upstream adopts the same binding shape.
- **Upstream PR:** pending (link will be added here once opened).

## Usage (Rust)

```toml
[dependencies]
tree-sitter = "0.25"
tree-sitter-json5 = { git = "…", tag = "v0.25.0-fork.1" }
```

```rust
let mut parser = tree_sitter::Parser::new();
parser
    .set_language(&tree_sitter_json5::LANGUAGE.into())
    .expect("Error loading json5 parser");
let tree = parser.parse("{ key: 'value', }", None).unwrap();
assert!(!tree.root_node().has_error());
```

## Tests

`cargo test` runs the binding load test plus a smoke suite that parses the
12 synthetic JSON5 files under `test/corpus_smoke/` and asserts an
error-node ratio below 5% per file (measured: 0% on all files) and the
presence of the expected node kinds (`object`, `array`, `member`, `comment`).

## License

MIT, unchanged from upstream — see [LICENSE](LICENSE).

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
