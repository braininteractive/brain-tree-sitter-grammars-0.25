# tree-sitter-sass

> **Provenance (fork):** forked from <https://github.com/bajrangCoder/tree-sitter-sass>
> (commit `fb280c4`, 2026-01-18). This is the **indented `.sass` syntax** (indentation
> instead of braces, newlines instead of semicolons) — distinct from the braced `.scss`
> syntax, which is covered by a separate grammar.
> **Changes vs upstream:** created the Rust binding set from scratch (upstream shipped no
> Rust crate): `Cargo.toml`, `bindings/rust/lib.rs` exposing
> `pub const LANGUAGE: tree_sitter_language::LanguageFn`, and `bindings/rust/build.rs`
> compiling `parser.c` + the external indent/dedent `scanner.c`. `parser.c` regenerated
> with tree-sitter-cli 0.25.10 (ABI 15); `src/node-types.json` committed; added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> **Known gaps:** `@each $x in a, b, c` comma-separated lists (bare or quoted) do not parse
> cleanly — the `each_statement` list handling is incomplete upstream. `@if`/`@else if`/
> `@else`, `@for`, `@while`, `@mixin`/`@include`, `@function`, `@use`/`@import`/`@forward`,
> nesting, parent selectors, interpolation, and placeholders all parse cleanly.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves.
> **Upstream PR:** pending (link will be added here once opened).

A [Tree-sitter](https://tree-sitter.github.io/) grammar for **Sass indented syntax** (`.sass` files).

## License

MIT

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
