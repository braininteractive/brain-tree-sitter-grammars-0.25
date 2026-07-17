# tree-sitter-toml-ng (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-toml>
> (commit `64b56832c2cffe41758f28e05c756a3a98d16f41`, 2024-12-03).
> **Changes vs upstream:** `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15);
> crate version aligned to `0.25.0` for this fork line (upstream crate `tree-sitter-toml-ng`
> is `0.7.0` — deliberate: consumed only as a git-tag dependency; never publish to a registry
> under the upstream name); `tree-sitter` dev-dependency bumped 0.24 -> 0.25; added a
> synthetic smoke-test corpus (`test/corpus_smoke/`, 12 files) and `tests/smoke.rs`.
> External C scanner kept verbatim. No grammar-rule changes. Package name
> `tree-sitter-toml-ng` kept verbatim — drop-in replacement for the crates.io release.
> Upstream corpus: 18/18; smoke corpus: 0.00% error nodes.
> **Rebase policy:** regen/tests-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending (link will be added here once opened).

# tree-sitter-toml

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-toml/actions)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/@tree-sitter-grammars/tree-sitter-toml)
[![crates][crates]](https://crates.io/crates/tree-sitter-toml-ng)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-toml/)

A tree-sitter parser for TOML files.

## References

- [TOML v1.0.0](https://toml.io/en/v1.0.0)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-toml/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/%40tree-sitter-grammars%2Ftree-sitter-toml?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-toml-ng?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-toml?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
