# tree-sitter-gomod

> **Provenance (fork):** forked from <https://github.com/camdencheek/tree-sitter-go-mod>
> (commit `2e88687`, 2025-10-22).
> **Changes vs upstream:** none to the grammar or the generated parser — upstream is
> already ABI 15 with the `tree-sitter-language` `LanguageFn` binding and a
> `tree-sitter.json`; this is a pin-style fork. Cargo package version set to `0.25.0`
> (edition 2021) with `tree-sitter = "0.25"` as a dev-dependency; added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`; doc-example now parses
> a small go.mod snippet. No grammar-rule changes.
> **Rebase policy:** pin-only diff, rebased onto upstream when it moves; retired if
> the upstream crates.io release catches up to HEAD.
> **Upstream PR:** pending (link will be added here once opened).

[tree-sitter][] grammar for go.mod files.

[tree-sitter]: https://github.com/tree-sitter/tree-sitter

## Status

The grammar is fairly small, and has been working well for highlighting for me. 
I expect it to evolve slightly to better fit tree-sitter best practices, but there shouldn't
be anything major. 

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
