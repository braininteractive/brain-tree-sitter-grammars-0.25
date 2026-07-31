# tree-sitter-julia (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter/tree-sitter-julia>
> (commit `e0f9dcd`, 2025-11-08).
> **Changes vs upstream:** pin-style — official grammar, already ABI 15 + LanguageFn;
> version aligned to 0.25.0, dev-dep pinned 0.25; added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-julia`
> kept verbatim. Upstream corpus: 63/63; smoke corpus: 0.00% error nodes under the cargo
> <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-julia

[![CI][ci]](https://github.com/tree-sitter/tree-sitter-julia/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-julia)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-julia)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-julia/)

A [tree-sitter](https://github.com/tree-sitter/tree-sitter) parser for [Julia](https://julialang.org/).

## References

- [The Julia Parser](https://github.com/JuliaLang/julia/blob/master/src/julia-parser.scm)
- [Julia ASTs documentation](https://docs.julialang.org/en/v1/devdocs/ast/)
- [JuliaSyntax.jl](https://julialang.github.io/JuliaSyntax.jl/dev/)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter/tree-sitter-julia/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-julia?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-julia?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-julia?logo=pypi&logoColor=ffd242



## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
