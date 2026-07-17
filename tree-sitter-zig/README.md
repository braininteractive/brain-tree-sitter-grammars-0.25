# tree-sitter-zig (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-zig>
> (commit `6479aa13f32f701c383083d8b28360ebd682fb7d`, 2025-09-10).
> **Changes vs upstream:** pin-style fork — upstream already ships ABI 15 `parser.c`, a
> `tree-sitter.json`, and a modern `tree-sitter-language` `LanguageFn` Rust binding (no
> external scanner). Diff is minimal: crate version aligned to `0.25.0` for this fork line
> (upstream crate `tree-sitter-zig` is `1.1.2` — deliberate: consumed only as a git-tag
> dependency; never publish to a registry under the upstream name, `0.25.0 < 1.1.2` would
> register as a downgrade); added a synthetic smoke-test corpus (`test/corpus_smoke/`,
> 12 files) and `tests/smoke.rs`. No grammar-rule changes. Package name `tree-sitter-zig`
> kept verbatim — drop-in replacement for the crates.io release.
> **Validation note:** upstream ships no `tree-sitter test` corpus at this revision; the
> 12-file smoke corpus (structs, enums/unions, error sets, comptime, control flow,
> optionals, allocators, tests, pointers/slices, builtins, multiline strings) parses at
> 0.00% error nodes under the cargo smoke gate.
> **Rebase policy:** tests-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.
> **Upstream PR:** n/a (no code change).

# tree-sitter-zig

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-zig/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-zig)
[![npm][npm]](https://www.npmjs.com/package/@tree-sitter-grammars/tree-sitter-zig)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-zig)

Zig grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## References

- [Zig Grammar](https://github.com/ziglang/zig-spec/blob/master/grammar/grammar.y)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-zig/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/@tree-sitter-grammars/tree-sitter-zig?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-zig?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-zig?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
