# tree-sitter-kotlin-ng (fork)
> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-kotlin>
> (commit `3dea6dfa9c0129deb7c4315afbda806c85c41667`, 2025-01-16).
> **Changes vs upstream:** pin-style fork — upstream is actively maintained and already ships
> ABI 15 `parser.c` and a modern `tree-sitter-language` `LanguageFn` Rust binding. Diff is
> minimal: crate version aligned to `0.25.0` for this fork line (upstream crate
> `tree-sitter-kotlin-ng` is `1.1.0` — deliberate: consumed only as a git-tag dependency;
> never publish to a registry under the upstream name, `0.25.0 < 1.1.0` would register as a
> downgrade); `tree-sitter` dev-dependency bumped 0.24 → 0.25; added a synthetic smoke-test
> corpus (`test/corpus_smoke/`, 12 files) and `tests/smoke.rs`. No grammar-rule changes.
> Package name `tree-sitter-kotlin-ng` kept verbatim — drop-in replacement for the
> crates.io release. Upstream corpus: 22/22; smoke corpus: 0.00% error nodes.
> **C-symbol rename (2026-07-17, fork.5):** grammar name changed `kotlin` -> `kotlin_ng`,
> so the exported C symbols are now `tree_sitter_kotlin_ng` /
> `tree_sitter_kotlin_ng_external_scanner_*`. Reason: crates.io's `tree-sitter-kotlin-sg`
> (pulled transitively by ast-grep-language) exports the same `tree_sitter_kotlin` symbol;
> at link time the duplicate resolved to the ABI-14 sg parser and silently broke this
> grammar (0 symbols extracted). The rename makes the two crates coexist, and `links = "tree_sitter_kotlin_ng"` (fork.6) turns any future duplicate into a hard cargo build error instead of a silent mislink. Rust consumers
> are unaffected (`tree_sitter_kotlin_ng::LANGUAGE` as before); C/FFI consumers must use
> the new symbol. Node kinds are unchanged.
> **Rebase policy:** binding/tests-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.
> **Upstream PR:** n/a (no code change).

# tree-sitter-kotlin

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-kotlin/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-kotlin-ng)
[![npm][npm]](https://www.npmjs.com/package/@tree-sitter-grammars/tree-sitter-kotlin)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-kotlin)

Kotlin grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## References

- [Kotlin Grammar](https://kotlinlang.org/docs/reference/grammar.html)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-kotlin/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/@tree-sitter-grammars/tree-sitter-kotlin?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-kotlin-ng?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-kotlin?logo=pypi&logoColor=ffd242

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
