# tree-sitter-thrift

> **Provenance (fork):** forked from <https://github.com/duskmoon314/tree-sitter-thrift>
> (commit `68fd0d8`, 2024-04-20).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); added a
> `tree-sitter.json` manifest (required by the 0.25 CLI to emit ABI 15); added a
> synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[![Build Status](https://github.com/duskmoon314/tree-sitter-thrift/actions/workflows/ci.yml/badge.svg)](https://github.com/duskmoon314/tree-sitter-thrift/actions/workflows/ci.yml)
[![Discord](https://img.shields.io/discord/1063097320771698699?logo=discord)](https://discord.gg/w7nTvsVJhm)

Thrift grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter)

Adapted from [Thrift interface description language](https://thrift.apache.org/docs/idl)
and all thrift files found at <https://github.com/apache/thrift>

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
