# tree-sitter-lua (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-lua>
> (commit `10fe005`, 2026-02-26).
> **Changes vs upstream:** pin-style — upstream already ABI 15 + LanguageFn + tree-
> sitter.json; version aligned to 0.25.0, dev-dep pinned 0.25; added a synthetic smoke-
> test corpus (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-
> sitter-lua` kept verbatim. Upstream corpus: 44/44; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-lua

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-lua/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/%40tree-sitter-grammars%2Ftree-sitter-lua)
[![crates][crates]](https://crates.io/crates/tree-sitter-lua)

Lua grammar for tree-sitter.

- Lua 5.x
- LuaJIT 2.x

## References

- [Lua Documentation](https://www.lua.org/docs.html)

## Acknowledgement

The [external scanner](/src/scanner.c) was initially based on these repositories:

- [Azganoth/tree-sitter-lua](https://github.com/Azganoth/tree-sitter-lua)
- [euclidianAce/tree-sitter-teal](https://github.com/euclidianAce/tree-sitter-teal)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-lua/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/%40tree-sitter-grammars%2Ftree-sitter-lua?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-lua?logo=rust


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
