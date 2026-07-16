# tree-sitter-go-sum

> **Provenance (fork):** forked from <https://github.com/amaanq/tree-sitter-go-sum>
> (commit `27816eb`, 2025-07-10).
> **Changes vs upstream:** `src/parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 14 -> 15); upstream already uses the `tree-sitter-language` `LanguageFn`
> binding and ships a `tree-sitter.json`. Cargo package version set to `0.25.0`;
> added a synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** regeneration-only diff, rebased onto upstream when it moves;
> retired if upstream regenerates at ABI 15.
> **Upstream PR:** pending (link will be added here once opened).

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-go-sum/actions)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-go-sum)
[![crates][crates]](https://crates.io/crates/tree-sitter-go-sum)

A tree-sitter parser for go.sum files.

## References

- [go.sum](https://go.dev/ref/mod#go-sum-files)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-go-sum/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-go-sum?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-go-sum?logo=rust

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
