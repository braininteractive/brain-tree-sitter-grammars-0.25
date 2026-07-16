# tree-sitter-less

> **Provenance (fork):** forked from <https://github.com/jimliang/tree-sitter-less>
> (commit `e5ae624`, 2025-10-30).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added `tree-sitter.json` (required by tree-sitter-cli 0.25 for ABI 15);
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); the external
> scanner (`src/scanner.c`) is unchanged and still compiled by `build.rs`; added a
> synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[![CI][ci]](https://github.com/jimliang/tree-sitter-less/actions/workflows/ci.yml)
[![crates][crates]](https://crates.io/crates/tree-sitter-less)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-less)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-less)

[LESS](https://lesscss.org/) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

[ci]: https://img.shields.io/github/actions/workflow/status/jimliang/tree-sitter-less/ci.yml?logo=github&label=CI
[npm]: https://img.shields.io/npm/v/tree-sitter-less?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-less?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-less?logo=pypi&logoColor=ffd242

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
