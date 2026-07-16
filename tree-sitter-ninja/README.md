# tree-sitter-ninja

> **Provenance (fork):** forked from <https://github.com/alemuller/tree-sitter-ninja>
> (commit `0a95cfd`, 2022-01-07).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); added a minimal
> `tree-sitter.json` (required by the 0.25 CLI to emit ABI 15); exposed
> `HIGHLIGHTS_QUERY`; added a synthetic smoke-test corpus (`test/corpus_smoke/`)
> and `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[ninja](https://github.com/ninja-build/ninja/) grammar for tree-sitter

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
