# tree-sitter-doxygen

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-doxygen>
> (commit `ccd998f`, 2024-06-09).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added `tree-sitter.json` (required for ABI 15 generation); `parser.c` regenerated
> with tree-sitter-cli 0.25.10 (ABI 15); added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **/// support (2026-07-17, fork.5):** triple-slash doc comments (`///`, `//!`, `///<`)
> now parse — upstream's multiline opener token also matched `///` and then demanded a
> `*/` terminator, erroring every triple-slash block. Opener anchored on literal `/*`,
> single-line opener extended with `repeat('/')`, and continuation-line `///` prefixes
> skipped like leading `*`s. Upstream corpus still 33/33 + 2 new regression tests.
> **Upstream PR:** pending (link will be added here once opened).

[![Build Status](https://github.com/amaanq/tree-sitter-doxygen/actions/workflows/ci.yml/badge.svg)](https://github.com/amaanq/tree-sitter-doxygen/actions/workflows/ci.yml)
[![Discord](https://img.shields.io/discord/1063097320771698699?logo=discord)](https://discord.gg/w7nTvsVJhm)

[Doxygen](https://www.doxygen.nl/manual/commands.html) grammar for [tree-sitter](https://tree-sitter.github.io)

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
