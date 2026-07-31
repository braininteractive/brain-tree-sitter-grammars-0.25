# tree-sitter-properties (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-properties>
> (commit `6310671`, 2025-07-14).
> **Changes vs upstream:** parser.c regenerated with CLI 0.25.10 (ABI 14 -> 15); version
> aligned to 0.25.0, dev-dep pinned 0.25, edition 2021; added a synthetic smoke-test
> corpus (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-
> properties` kept verbatim. Upstream corpus: 5/5; smoke corpus: 0.00% error nodes under
> the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-properties

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-properties/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#nvim-treesitter:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-properties)
[![crates][crates]](https://crates.io/crates/tree-sitter-properties)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-properties/)

A tree-sitter parser for Java properties files.

## References

* [Properties](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Properties.html#load%28java.io.Reader%29)
* [Property Expressions](https://quarkus.io/guides/config-reference#property-expressions)
* [Property Placeholders](https://docs.spring.io/spring-boot/docs/3.2.x/reference/htmlsingle/#features.external-config.files.property-placeholders)

## Editors

- [x] Neovim
- [ ] Helix
- [ ] Emacs
- [ ] Zed

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-properties/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=tree-sitter
[matrix]: https://img.shields.io/matrix/nvim-treesitter%3Amatrix.org?logo=matrix&label=nvim-treesitter
[npm]: https://img.shields.io/npm/v/tree-sitter-properties?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-properties?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-properties?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
