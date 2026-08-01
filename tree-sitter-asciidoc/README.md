# tree-sitter-asciidoc (fork, dual grammar)

> **Provenance (fork):** forked from <https://github.com/cathaysia/tree-sitter-asciidoc>
> (commit `e0710115e7b060ce6681b5182a49a792813006f1`, 2026-07-20).
> **Changes vs upstream:** two crates (`tree-sitter-asciidoc` block grammar +
> `tree-sitter-asciidoc-inline`), both already ABI 15 — legacy bindings rewritten to the
> `tree-sitter-language` `LanguageFn` API; versions aligned to `0.25.0`; smoke corpus
> (10 files) + tests/smoke.rs added to the block crate. Known gap: the revision line's
> date part (`v1.0, 2026-01-01`) in the document header errors — upstream limitation.
> Upstream corpora: 57/57 (block) + 63/63 (inline); smoke corpus 0.00%.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# tree-sitter-asciidoc

[![tree-sitter-asciidoc on crates.io](https://img.shields.io/crates/v/tree-sitter-asciidoc?label=tree-sitter-asciidoc)](https://crates.io/crates/tree-sitter-asciidoc)
[![tree-sitter-asciidoc-inline on crates.io](https://img.shields.io/crates/v/tree-sitter-asciidoc-inline?label=tree-sitter-asciidoc-inline)](https://crates.io/crates/tree-sitter-asciidoc-inline)

[tree-sitter](https://tree-sitter.github.io/tree-sitter/) grammar for [AsciiDoc](https://docs.asciidoctor.org/asciidoc/latest/).


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
