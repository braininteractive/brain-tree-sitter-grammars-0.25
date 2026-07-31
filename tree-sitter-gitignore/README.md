# tree-sitter-ignore (fork)

> **Provenance (fork):** forked from <https://github.com/shunsambongi/tree-sitter-gitignore>
> (commit `f4685bf11ac466dd278449bcfe5fd014e94aa504`, 2022-05-04).
> **Changes vs upstream:** full modernization from 0.13-era: ABI 13 -> 15, tree-
> sitter.json, LanguageFn binding. Upstream dormant but the gitignore format is frozen.
> NOTE: crate name is `tree-sitter-ignore` (upstream naming), C symbol
> tree_sitter_gitignore; added a synthetic smoke-test corpus (test/corpus_smoke/, 10
> files) and tests/smoke.rs. Upstream corpus: 14/14; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-gitignore

A tree-sitter parser for `.gitignore` files.



## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
