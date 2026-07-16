tree-sitter-sparql
==================

> **Provenance (fork):** forked from <https://github.com/GordianDziwis/tree-sitter-sparql>
> (commit `1ef52d3`, 2025-10-15).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); Cargo.toml `repository`
> corrected to this grammar's own URL (upstream pointed at tree-sitter-javascript by
> mistake); added a synthetic smoke-test corpus (`test/corpus_smoke/`) and
> `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

SPARQL grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
