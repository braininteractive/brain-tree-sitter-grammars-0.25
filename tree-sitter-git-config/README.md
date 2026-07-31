# tree-sitter-git-config (fork)

> **Provenance (fork):** forked from <https://github.com/the-mikedavis/tree-sitter-git-config>
> (commit `3a61756a81a86291a0f48e3eeeaa0692b9981aa9`, 2026-07-20).
> **Changes vs upstream:** ABI 14 -> 15 regen; LanguageFn binding written fork-side;
> version aligned to 0.25.0; added a synthetic smoke-test corpus (test/corpus_smoke/, 10
> files) and tests/smoke.rs. Upstream corpus: 15/15; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# `tree-sitter-git-config`

[![CI](https://github.com/the-mikedavis/tree-sitter-git-config/actions/workflows/ci.yml/badge.svg)](https://github.com/the-mikedavis/tree-sitter-git-config/actions/workflows/ci.yml)

A [tree-sitter](https://tree-sitter.github.io/tree-sitter/) grammar for git's configuration language

NOTE: when contributing, you can skip checking in the changes from `tree-sitter generate`. CI will push a commit to regenerate the parser on merge.


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
