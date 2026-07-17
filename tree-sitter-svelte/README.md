# tree-sitter-svelte-ng (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-svelte>
> (commit `ae5199db47757f785e43a14b332118a5474de1a2`, 2024-10-19).
> **Changes vs upstream:** `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15);
> crate version aligned to `0.25.0` for this fork line (upstream crate `tree-sitter-svelte-ng`
> is `1.0.2` — deliberate: consumed only as a git-tag dependency; never publish to a registry
> under the upstream name, `0.25.0 < 1.0.2` would register as a downgrade); `tree-sitter`
> dev-dependency bumped 0.23 -> 0.25; added a synthetic smoke-test corpus
> (`test/corpus_smoke/`, 12 files) and `tests/smoke.rs`. External C scanner kept verbatim.
> No grammar-rule changes. Package name `tree-sitter-svelte-ng` kept verbatim — drop-in
> replacement for the crates.io release. Upstream corpus: 45/45; smoke corpus: 0.00% error
> nodes.
> **Rebase policy:** regen/tests-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending (link will be added here once opened).

# tree-sitter-svelte

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-svelte/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-svelte-ng)
[![npm][npm]](https://www.npmjs.com/package/@tree-sitter-grammars/tree-sitter-svelte)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-svelte)

[Svelte](https://svelte.dev/) grammar for [tree-sitter](https://tree-sitter.github.io)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-svelte/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/@tree-sitter-grammars/tree-sitter-svelte?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-svelte-ng?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-svelte?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
