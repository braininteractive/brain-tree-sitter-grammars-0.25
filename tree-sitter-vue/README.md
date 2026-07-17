# tree-sitter-vue (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-vue>
> (commit `ce8011a414fdf8091f4e4071752efc376f4afb08`, 2026-01-24).
> **Changes vs upstream:** upstream had already regenerated `parser.c` at ABI 15 and shipped
> a modern `LanguageFn` `lib.rs`/`build.rs`, but `Cargo.toml` still declared the legacy
> `tree-sitter = "~0.20.10"` hard dependency (crate could not build against a 0.25 runtime).
> Fixed: `[dependencies]` is now `tree-sitter-language = "0.1"` with `tree-sitter = "0.25"`
> as dev-dependency only; crate version aligned to `0.25.0` for this fork line;
> `tree-sitter.json` added to the packaged file list; added a synthetic smoke-test corpus
> (`test/corpus_smoke/`, 12 files) and `tests/smoke.rs`. External C scanner kept verbatim.
> No grammar-rule changes. Package name `tree-sitter-vue` kept verbatim.
> Upstream corpus: 10/10; smoke corpus: 0.00% error nodes.
> **Rebase policy:** binding/tests-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line crates.io release.
> **Upstream PR:** pending (Cargo.toml dependency fix is upstream-PR material).

# tree-sitter-vue

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-vue/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
<!-- NOTE: uncomment these if you're publishing packages: -->
<!-- [![npm][npm]](https://www.npmjs.com/package/tree-sitter-vue) -->
<!-- [![crates][crates]](https://crates.io/crates/tree-sitter-vue) -->

A tree-sitter parser for vue files.

## References

<!-- NOTE: add the grammar's references here -->

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-vue/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-vue?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-vue?logo=rust


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
