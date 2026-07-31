# tree-sitter-gitcommit (fork)

> **Provenance (fork):** forked from <https://github.com/gbprod/tree-sitter-gitcommit>
> (commit `49715a9e6f19ce3d33b875aacdd6ad8ddaee0ffe`, 2026-05-13).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn (external scanner
> kept verbatim); version aligned to 0.25.0. Handles conventional commits, trailers,
> scissors/verbose diffs, status comments; added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus: 64/64; smoke
> corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-gitcommit

[![Build/test](https://github.com/gbprod/tree-sitter-gitcommit/actions/workflows/ci.yml/badge.svg)](https://github.com/gbprod/tree-sitter-gitcommit/actions/workflows/ci.yml)

`gitcommit` grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## Features

- Support for [Conventional Commits](https://www.conventionalcommits.org) specifications.
- Support for different locales / languages. See [Supported locales](#supported-locales) for a full list.

## Supported locales

We aim to support all the [locales supported by git](https://github.com/git/git/tree/master/po).
The currently supported locales are listed below:

- `en`: English
- `bg`: Bulgarian
- `ca`: Catalan
- `de`: German
- `el`: Greek
- `es`: Spanish
- `fr`: French
- `id`: Indonesian (Bahasa)
- `it`: Italian
- `ko`: Korean
- `pl`: Polish
- `pt_PT`: Portugal Portugese
- `ru`: Russian
- `sv`: Swedish
- `tr`: Turkish
- `vi`: Vietnamese
- `zh_CN`: Chinese (Simplified)
- `zh_TW`: Taiwanese Mandarin

## Note about injected languages

This parser _only_ parses git commit subject, message and generated comments, it doesn't handle diff and git rebase information that could be included.
To handle that, you must have `diff` and `git_rebase` tree-sitter grammars installed and add injection queries.

If you're using Neovim and [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter), you just have to be sure that `diff` and `git_rebase` are installed (using `TSInstall diff git_rebase` for example).

## Upgrade translations

There is python script to upgrade translations from git source code. It will search for all translations in all tagged versions of git from the v2.30.2.
So this parser should be compatible with all git versions from v2.30.2.

To upgrade translations, run:

```bash
python parse-lang.py
```

## Credits

- [https://github.com/the-mikedavis/tree-sitter-git-commit](https://github.com/the-mikedavis/tree-sitter-git-commit) Good parser but [only works in English](https://github.com/the-mikedavis/tree-sitter-git-commit/issues/4).


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
