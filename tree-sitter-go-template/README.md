> **Provenance (fork):** forked from <https://github.com/ngalaiko/tree-sitter-go-template>
> (commit `aa71f63`, 2026-03-21).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); the `extern "C"` declaration fixed to the
> actual exported symbol `tree_sitter_gotmpl` (upstream's `bindings/rust/lib.rs`
> declared `tree_sitter_go_template`, which fails to link); `tree-sitter` moved to a
> dev-dependency; crate version bumped to 0.25.0, edition 2021; `parser.c` regenerated
> with tree-sitter-cli 0.25.10 (ABI 15); added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes; the `dialects/helm`
> sub-grammar and upstream queries are untouched.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

## Announcement

The original author stopped using helm (which he mostly wrote this package for) on a daily basis, so he didn't really keep up with the development of tree sitter, and nvim-tree-sitter.
Some people have been found to keep the repo going, so if you have ideas for improvements feel free to open issues or pull requests.

# tree-sitter-go-template

[![Build/test](https://github.com/ngalaiko/tree-sitter-go-template/actions/workflows/ci.yaml/badge.svg)](https://github.com/ngalaiko/tree-sitter-go-template/actions/workflows/ci.yaml)

[Golang templates][] grammar for [tree-sitter][].

Also includes a [helm][] dialect. The concept of a dialect is that it uses the same parser, but can have different queries (e.g. for different injections).
More dialects could be added in the future (e.g. for html templates).

## NeoVim integration using [nvim-treesitter][]

-   Setup filetype detection:

    -   using [lua](https://neovim.io/doc/user/lua.html#vim.filetype):

    ```lua
    vim.filetype.add({
      extension = {
        gotmpl = 'gotmpl',
      },
      pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
      },
    })
    ```

-   Install [nvim-treesitter][] as described here: [nvim-treesitter-install][]
-   Install the parser you want to use:

```vim
:TSInstall gotmpl
:TSInstall helm
```

### Highlighting for the templated language

To get proper highlighting for the language that is templated (e.g. html) you need to add injections for
that language to `.config/nvim/queries/gotmpl/injections.scm`:

```scm
((text) @injection.content
 (#set! injection.language "html")
 (#set! injection.combined))
```

Replace html with the tree-sitter name of your required language and make sure to install it with `:TSInstall`.

More advanced use cases would require adding more dialects (as done for helm).

> [!NOTE]
>
> If you are using helm, you should also install the yaml parser (:TSInstall yaml) to get [language injection][] for yaml.
>
> In case you are using [AstroNvim][] you can just install the [astrocommunity][] helm pack or when using [LazyVim][] its [LazyVimHelm] plugin.

[tree-sitter]: https://github.com/tree-sitter/tree-sitter
[Golang templates]: https://golang.org/pkg/text/template/
[nvim-treesitter instructions]: https://github.com/nvim-treesitter/nvim-treesitter#adding-parsers
[nvim-treesitter-install]: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#installation
[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter
[helm]: https://helm.sh
[vim-helm]: https://github.com/towolf/vim-helm
[language injection]: https://tree-sitter.github.io/tree-sitter/syntax-highlighting#language-injection
[AstroNvim]: https://github.com/AstroNvim/AstroNvim
[astrocommunity]: https://github.com/AstroNvim/astrocommunity
[LazyVim]: https://www.lazyvim.org/
[LazyVimHelm]: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/helm.lua

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
