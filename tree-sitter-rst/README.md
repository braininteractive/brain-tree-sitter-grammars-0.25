# tree-sitter-rst

> **Provenance (fork):** forked from <https://github.com/stsewd/tree-sitter-rst>
> (commit `a60f107`, 2026-06-09).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); `src/node-types.json`
> committed; added a synthetic smoke-test corpus (`test/corpus_smoke/`) and
> `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[![CI](https://github.com/stsewd/tree-sitter-rst/workflows/CI/badge.svg)](https://github.com/stsewd/tree-sitter-rst/actions?query=workflow%3ACI+branch%3Amaster)
[![PyPI - Version](https://img.shields.io/pypi/v/tree-sitter-rst)](https://pypi.org/project/tree-sitter-rst/)
[![NPM Version](https://img.shields.io/npm/v/tree-sitter-rst)](https://www.npmjs.com/package/tree-sitter-rst)
[![Crates.io Version](https://img.shields.io/crates/v/tree-sitter-rst)](https://crates.io/crates/tree-sitter-rst)

reStructuredText grammar for [tree-sitter](https://tree-sitter.github.io/tree-sitter/).
Based on the specification from  <https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html>.

Check the playground at <https://stsewd.dev/tree-sitter-rst/>.

**Note: this grammar is still under development, a lot of things may change!**

## TODO

- Allow lists with blank lines between items
- Refactor parse citation and footer reference
- Nested line blocks
- Option lists
- Add some nodes to inline?
- Check if there is a way to re-implement some nodes to JS instead of C?
- A definition list with classifiers can't be separated by a blank line.
- tests, tests, and more tests!

## Design notes

- Nodes that contain body elements inside (like lists or directives),
  are inside a node named `body`.
- In RST sections are a big node that contains body elements,
  here they are just a node containing the title.
  This is to avoid guessing the level of subtitles.
- In RST standalone hyperlinks are `reference` nodes,
  here they are `standalone_hyperlink` nodes.
  This is to avoid confusion with inline references nodes
  (that are a `reference` node).
- Literal blocks are part of the paragraph they precede, not a separate node,
  except for the expanded form of literal blocks.
- In rst directives only have "body" node,
  here the body is parsed as arguments/options/content.

## Design decisions

- Implement tables?
- Validate length of adornments in sections?

  The spec doesn't mention this, but this paragraph does.

  > The underline/overline must be at least as long as the title text.

  https://docutils.sourceforge.io/docs/user/rst/quickstart.html


## Projects using this grammar

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [helix](https://github.com/helix-editor/helix)
- [zed-rst](https://github.com/elmarco/zed-rst)
- Yours?

## Contributing

Check the [CONTRIBUTING.md](CONTRIBUTING.md) file

## Other grammars

- [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment): grammar for comment tags like `TODO`, `FIXME(user)`.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
