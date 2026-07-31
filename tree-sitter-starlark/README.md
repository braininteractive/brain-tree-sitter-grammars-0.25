# tree-sitter-starlark (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-starlark>
> (commit `a453dbf3ba433db0e5ec621a38a7e59d72e4dc69`, 2024-12-04).
> **Changes vs upstream:** ABI 14 -> 15 regen (grammar extends tree-sitter-python via
> npm at generate time — consumers unaffected); version aligned to 0.25.0. Covers
> BUILD/WORKSPACE/*.bzl; added a synthetic smoke-test corpus (test/corpus_smoke/, 10
> files) and tests/smoke.rs. Upstream corpus: 93/93; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-starlark

[![Build Status](https://github.com/tree-sitter-grammars/tree-sitter-starlark/actions/workflows/ci.yml/badge.svg)](https://github.com/tree-sitter-grammars/tree-sitter-starlark/actions/workflows/ci.yml)
[![Discord](https://img.shields.io/discord/1063097320771698699?logo=discord)](https://discord.gg/w7nTvsVJhm)

Starlark grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter)

Adapted from the [official spec](https://github.com/bazelbuild/starlark/blob/master/spec.md)
and the [Google spec](https://github.com/google/starlark-go/blob/master/doc/spec.md)


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
