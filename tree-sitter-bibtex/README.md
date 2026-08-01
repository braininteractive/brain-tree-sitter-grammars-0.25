# tree-sitter-bibtex (fork)

> **Provenance (fork):** forked from <https://github.com/latex-lsp/tree-sitter-bibtex>
> (commit `8d04ed27b3bc7929f14b7df9236797dab9f3fa66`, 2025-04-19).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0. Upstream ships no corpus; validated by the smoke corpus (entries, @string,
> @preamble, paren-delimited, unicode); added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus: smoke-only; smoke
> corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# tree-sitter-bibtex

[![CI](https://github.com/latex-lsp/tree-sitter-bibtex/workflows/CI/badge.svg)](https://github.com/latex-lsp/tree-sitter-bibtex/actions)

BibTeX grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).
This grammar finds use in the [TexLab](https://github.com/latex-lsp/texlab) language server.


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
