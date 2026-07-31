# tree-sitter-md (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-markdown>
> (commit `a0a00f8`, 2026-07-19).
> **Changes vs upstream:** pin-style dual grammar (block + inline, LANGUAGE /
> INLINE_LANGUAGE) — already ABI 15 + LanguageFn; version aligned to 0.25.0, optional
> `parser`-feature runtime dep pinned 0.26 -> 0.25. Known: 8 upstream inline corpus
> tests are extension-gated (wikilink etc., extensions not compiled into the default
> parser) and fail by design without those flags; added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-md` kept
> verbatim. Upstream corpus: block 322/322, inline 337 (+8 extension-gated); smoke
> corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-markdown

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-markdown/actions)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/@tree-sitter-grammars/tree-sitter-markdown)
[![crates][crates]](https://crates.io/crates/tree-sitter-md)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-markdown/)

A Markdown parser for [tree-sitter].

![screenshot](https://github.com/MDeiml/tree-sitter-markdown/blob/split_parser/.github/screenshot.png)

The parser is designed to read markdown according to the [CommonMark Spec],
but some extensions to the spec from different sources such as [Github flavored
markdown] are also included. These can be toggled on or off at compile time.
For specifics see [Extensions](#extensions)

## Goals

Even though this parser has existed for some while and obvious issues are
mostly solved, there are still lots of inaccuracies in the output. These stem
from restricting a complex format such as markdown to the quite restricting
tree-sitter parsing rules.

As such it is not recommended to use this parser where correctness is
important. The main goal for this parser is to provide syntactical information
for syntax highlighting in parsers such as [neovim] and [helix].

## Contributing

All contributions are welcome. For details refer to [CONTRIBUTING.md].

## Extensions

Extensions can be enabled at compile time through environment variables. Some
of them are on by default, these can be disabled with the environment variable
`NO_DEFAULT_EXTENSIONS`.

| Name | Environment variable | Specification | Default | Also enables |
|:----:|:--------------------:|:-------------:|:-------:|:------------:|
| Github flavored markdown | `EXTENSION_GFM` | [link](https://github.github.com/gfm/) | ✓ | Task lists, strikethrough, pipe tables |
| Task lists | `EXTENSION_TASK_LIST` | [link](https://github.github.com/gfm/#task-list-items-extension-) | ✓ |  |
| Strikethrough | `EXTENSION_STRIKETHROUGH` | [link](https://github.github.com/gfm/#strikethrough-extension-) | ✓ |  |
| Pipe tables | `EXTENSION_PIPE_TABLE` | [link](https://github.github.com/gfm/#tables-extension-) | ✓ |  |
| YAML metadata | `EXTENSION_MINUS_METADATA` | [link](https://gohugo.io/content-management/front-matter/) | ✓ |  |
| TOML metadata | `EXTENSION_PLUS_METADATA` | [link](https://gohugo.io/content-management/front-matter/) | ✓ |  |
| Tags | `EXTENSION_TAGS` | [link](https://help.obsidian.md/Editing+and+formatting/Tags#Tag+format) |  |  |
| Wiki Link | `EXTENSION_WIKI_LINK` | [link](https://help.obsidian.md/Linking+notes+and+files/Internal+links) |  |  |

## Usage in Editors

For guides on how to use this parser in a specific editor, refer to that
editor's specific documentation, e.g.
* [neovim](https://github.com/nvim-treesitter/nvim-treesitter)
* [helix](https://docs.helix-editor.com/guides/adding_languages.html)

## Standalone usage

To use the two grammars, first parse the document with the block
grammar. Then perform a second parse with the inline grammar using
`ts_parser_set_included_ranges` to specify which parts are inline content.
These parts are marked as `inline` nodes. Children of those inline nodes should
be excluded from these ranges. For an example implementation see `lib.rs` in
the `bindings` folder.

### Usage with WASM

Unfortunately using this parser with WASM/web-tree-sitter does not work out of the box at the moment. This is because the parser uses some C functions that are not exported by tree-sitter by default. To fix this you can statically link the parser to tree-sitter. See also https://github.com/tree-sitter/tree-sitter/issues/949, https://github.com/MDeiml/tree-sitter-markdown/issues/126, and https://github.com/MDeiml/tree-sitter-markdown/issues/93

[CommonMark Spec]: https://spec.commonmark.org/
[Github flavored markdown]: https://github.github.com/gfm/
[tree-sitter]: https://tree-sitter.github.io/tree-sitter/
[neovim]: https://neovim.io/
[helix]: https://helix-editor.com/
[CONTRIBUTING.md]: https://github.com/MDeiml/tree-sitter-markdown/blob/split_parser/CONTRIBUTING.md
[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-markdown/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/%40tree-sitter-grammars%2Ftree-sitter-markdown?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-md?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-markdown?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
