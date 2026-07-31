# tree-sitter-jsonc (fork)

> **Provenance (fork):** forked from <https://gitlab.com/WhyNotHugo/tree-sitter-jsonc>
> (commit `f7890ba894d885d1b2b721cfae759b07d53c8886`, 2026-01-28).
> **Changes vs upstream:** full modernization from 0.13-era: ABI 13 -> 15, tree-
> sitter.json, LanguageFn binding. GRAMMAR FIX fork-side: trailing commas in
> objects/arrays now parse (upstream only added comments to JSON; tsconfig/VS Code files
> use trailing commas pervasively) — regression corpus test added; added a synthetic
> smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus:
> 1/1 (upstream shipped none); smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

tree-sitter-jsonc
===========================

[tree-sitter-json](https://github.com/tree-sitter/tree-sitter-json) now
supports both JSON and JSONC. This package is obsolete. There's not point in
using it.

---

JSONC grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter)

Heavily based on [tree-sitter-json](https://github.com/tree-sitter/tree-sitter-json).


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
