# tree-sitter-jsonnet

> **Provenance (fork):** forked from <https://github.com/sourcegraph/tree-sitter-jsonnet>
> (commit `ddd075f`, 2024-08-15).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added `tree-sitter.json` (required by tree-sitter-cli 0.25 to emit ABI 15);
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); external C
> scanner (`src/scanner.c`) kept and still compiled by `bindings/rust/build.rs`;
> **fixed a thread-safety bug in the external scanner** (state lived in file-scope
> globals instead of the per-parser payload, so parsers on different threads raced
> and intermittently mis-parsed strings — state moved into a heap-allocated
> `Scanner` struct returned by `..._create`);
> added a synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

tree-sitter grammar for JSONNET

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
