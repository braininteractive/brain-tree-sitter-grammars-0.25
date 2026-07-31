# tree-sitter-scss (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-scss>
> (commit `2ef6d42`, 2026-03-26).
> **Changes vs upstream:** full 0.25-line modernization: parser.c regenerated (ABI 14 ->
> 15; grammar extends tree-sitter-css via npm at generate time); added tree-sitter.json;
> lib.rs rewritten from legacy `language()` to the LanguageFn API; Cargo `tree-sitter
> >=0.21` hard dep replaced by tree-sitter-language 0.1 (tree-sitter 0.25 dev-only);
> version aligned to 0.25.0. Known upstream grammar gaps (documented, shared by the
> crates.io 1.0.0 build): Sass module system (`@use ... as`, `@forward ... show`),
> `@extend %placeholder` targets, map literals `(k: v)`, interpolation inside url()
> strings, child combinator at nested positions, multi-path @import; added a synthetic
> smoke-test corpus (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name
> `tree-sitter-scss` kept verbatim. Upstream corpus: 56/56; smoke corpus: 0.00% error
> nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-scss

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-scss/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-scss)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-scss)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-scss)

[SCSS](https://sass-lang.com/documentation) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-scss/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-scss?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-scss?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-scss?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
