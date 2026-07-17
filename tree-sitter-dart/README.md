# tree-sitter-dart (fork)

> **Provenance (fork):** forked from <https://github.com/UserNobody14/tree-sitter-dart>
> (commit `be07cf7118d3dba06236a3f19541685a68209934`, 2026-07-06) — the canonical,
> actively-maintained Dart grammar. (The crates.io `tree-sitter-dart 0.2.0` tracks a
> side-fork, not this repo.)
> **Changes vs upstream:** `bindings/rust/lib.rs` rewritten from the legacy
> `pub fn language()` shape to the `tree-sitter-language` `LanguageFn` API
> (`pub const LANGUAGE`); `Cargo.toml`: `tree-sitter = "0.22.6"` hard dependency replaced
> by `tree-sitter-language = "0.1"` (with `tree-sitter = "0.25"` dev-only), version
> `0.25.0` (fork line), edition 2021, repository URL corrected (upstream scaffold pointed
> at tree-sitter-javascript), `tree-sitter.json` packaged; added a synthetic smoke-test
> corpus (`test/corpus_smoke/`, 12 files incl. null-safety, async/streams, records &
> patterns, sealed classes, mixins, extension methods) and `tests/smoke.rs`. `parser.c`
> already ABI 15 upstream; external C scanner kept verbatim. No grammar-rule changes.
> Upstream corpus: 197/197; smoke corpus: 0.00% error nodes.
> **Rebase policy:** binding/tests diff, rebased onto upstream when it moves; retired if
> upstream publishes an equivalent 0.25-line crate.
> **Upstream PR:** pending (binding modernization is upstream-PR material).

# tree-sitter-dart
This is a tree-sitter grammar written for the dart programming language. We attempt to adhere as closely as possible to the dart language spec. Initially it was started with a copy of the tree-sitter Java grammar which is why there may be a few relics included in here. For the sake of simplifying the syntax tree, many items were made inlined with tree-sitter's "underscore" method of writing rules.

# Getting Started
- Go to the project directory
- run `npm install` (first time)
- run `npm run build_init` (first time) `npm run build` (subsequent times)
- run `npm run test`

# To test a single highlight file
- run `tree-sitter highlight test/highlight/types.dart`

# To test a single test file
- run `tree-sitter test -f 'testcasefilter'`
- for example `tree-sitter test -f 'dart string literals'`

# To show the output of a parse for a sample file (for example while debugging highlight issues)
- run `tree-sitter parse path/to/file.dart`

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
