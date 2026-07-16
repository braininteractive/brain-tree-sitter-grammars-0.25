# tree-sitter-twig

> **Provenance (fork):** forked from <https://github.com/gbprod/tree-sitter-twig>
> (commit `0afd9a6`, 2026-05-13).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added `tree-sitter.json` (required for ABI 15) and regenerated `parser.c` with
> tree-sitter-cli 0.25.10 (ABI 15); added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> `queries/injections.scm` preserved verbatim from upstream (note: it references
> `style_content`/`js_content`/`json_content` node types that do not exist in this
> grammar yet — upstream updated queries ahead of the grammar).
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[Twig](https://twig.symfony.com/) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

[![Build/test](https://github.com/gbprod/tree-sitter-twig/actions/workflows/ci.yml/badge.svg)](https://github.com/gbprod/tree-sitter-twig/actions/workflows/ci.yml)

## Installation

### Neovim

Grammar is available with [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter).

```vim
:TSInstall twig
```

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
