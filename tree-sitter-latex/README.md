# tree-sitter-latex (fork)

> **Provenance (fork):** forked from <https://github.com/latex-lsp/tree-sitter-latex>
> (commit `7e0ecdc02926c7b9b2e0c76003d4fe7b0944f957`, 2025-09-19).
> **Changes vs upstream:** upstream commits no parser.c — generated with CLI 0.25.10
> (ABI 15) and committed fork-side; legacy binding rewritten to LanguageFn; tree-sitter
> dev-dep added; added a synthetic smoke-test corpus (test/corpus_smoke/, 10 files) and
> tests/smoke.rs. Upstream corpus: 104/104; smoke corpus: 0.00% error nodes under the
> cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# tree-sitter-latex

[![CI](https://github.com/latex-lsp/tree-sitter-latex/workflows/CI/badge.svg)](https://github.com/latex-lsp/tree-sitter-latex/actions)
[![npm](https://img.shields.io/npm/v/@pfoerster/tree-sitter-latex)](https://www.npmjs.com/package/@pfoerster/tree-sitter-latex)

This repo provides a [LaTeX](https://www.latex-project.org/) grammar for the [tree-sitter](https://github.com/tree-sitter/tree-sitter) parser generator.

Originally, this grammar is based off the parser of the [`texlab`](https://github.com/latex-lsp/texlab) language server and primarily focuses on the constructs that are relevant for the language server.

This repository does not provide the accompanying highlighting definitions, instead they live in the [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries/latex) repository.

To generate the parser, run

```
npx tree-sitter generate
```

after checking out the repository.

## Limitations

As widely known, parsing LaTeX is Turing complete so there is no way to handle every construct in a `tree-sitter` grammar. Instead, the grammar relies on a best effort approach while focusing on the LaTeX specific constructs like environments or sections instead of dealing with TeX internals like catcode.


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
