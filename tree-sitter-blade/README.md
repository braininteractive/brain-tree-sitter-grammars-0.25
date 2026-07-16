# Tree-Sitter-Blade 🌳

> **Provenance (fork):** forked from <https://github.com/EmranMR/tree-sitter-blade>
> (commit `5dbdcb0`, 2026-04-27).
> **Changes vs upstream:** `parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 15); crate version set to `0.25.0` for the 0.25 fork line (upstream's Rust
> binding already uses the `tree-sitter-language` `LanguageFn` API and exposes
> `HIGHLIGHTS_QUERY` / `INJECTIONS_QUERY`, both kept as-is); external scanner
> (`src/scanner.c`) kept compiled; added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. The `queries/` directory
> (including `injections.scm` for the embedded PHP/HTML/JS regions) is preserved
> verbatim. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream publishes an equivalent 0.25 crate.
> **Upstream PR:** pending (link will be added here once opened).

---

### ⚠️v0.12.0 Upgrade Guide ✨

- The grammar has been pretty much rewritten from the ground up.
  _tree-sitter-blade_ now inherits `html` and takes control of the `html` tree
  structure as well
- The grammar is way more semantic, leaner and much faster, like lightening fast
  (10x) thanks to the drastically improved performance
- Please read the `v0.12.0`
  [Release Note for the Upgrade Guide](https://github.com/EmranMR/tree-sitter-blade/releases/tag/v0.12.0),
  if you have any questions, feel free to start a discussion or raise an issue

## Introduction (feel free to skip)

This project aims to write the tree-sitter grammar for
[Laravel Blade](https://laravel.com/docs/10.x/blade#main-content).

This grammar can be used in any editor or service that support
[Tree-Sitter](https://github.com/tree-sitter/tree-sitter). Such as, but not
limited to:

- **_Neovim_**
- **_Zed_**
- **_Nova_**

<img src="https://raw.githubusercontent.com/EmranMR/Laravel-Nova-Extension/main/Images/screenshot.png" width="60%" style="border-radius: 2%" alt="php injection" title="php injection" />

## Common Editors Set Up 💻

### <img src="https://github.com/EmranMR/Laravel-Nova-Extension/blob/main/Laravel.novaextension/extension.png?raw=true" width="30px" style="position: relative; right:5px; top:10px" alt="alt text" title="Nova" /> Nova

Simply install the
[Laravel Suite Extension](https://extensions.panic.com/extensions/emran-mr/emran-mr.laravel/)
from the Extension Library. That includes:

1. Language Injections
2. Autocompletion
3. Folding
4. Syntax Highlighting
5. Auto Indentation

### <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Neovim-mark.svg/500px-Neovim-mark.svg.png" width="25px" style="position: relative; right:5px; top:10px " alt="alt text" title="Neovim" />eoVim

Simply use the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin and install the `blade` grammar.

### <img src="https://upload.wikimedia.org/wikipedia/commons/1/16/Zed_Editor_Logo.png" width="30px" style="position: relative; right:5px; top:10px" alt="alt text" title="Zed" /> Zed

Simply
[download the extension](https://github.com/bajrangCoder/zed-laravel-blade) from
zed Extension marketplace

## Queries

> [!NOTE]
> Your editor or service might use a different **_capture group_** name or
> **_predicates_** than the queries in the `queries/` folder. Consequently, you
> will need to find out how to approach queries or where they are stored and
> used in your editor's documentation. For example **_Nova_** does not use
> anything in this folder and uses its own `Queries` folder instead.

Here's an example of all the various languages that are injected:

<img src="https://github.com/EmranMR/Laravel-Nova-Extension/blob/main/Images/Envoy%20Injection.png?raw=true" width="60%" style="border-radius: 2%" alt="php injection" title="php injection" />

And here's an example of folding in action:

<img src="https://raw.githubusercontent.com/EmranMR/Laravel-Nova-Extension/main/Images/folding.gif" width="60%" style="border-radius: 2%" alt="php injection" title="php injection" />

## Issues

If something does not look right please raise an
[issue](https://github.com/EmranMR/tree-sitter-blade/issues) with a detailed
examples of what you are trying to achieve. Add any of the following if
necessary:

- Code Excerpts (allows me to test)
- Photo of the issue
- Parse Tree (if inspectable by your editor)

If you need help with anything else or would like to share tips and tricks for
your fellow devs, feel free to use the
[discussion tab](https://github.com/EmranMR/tree-sitter-blade/discussions) and
create a discussion!

## 👥 Contributing

See the [contribution](/CONTRIBUTING.md) guidelines for more details, as well as
in depth info about the `grammar` itself.

## Anyone said coffee? ☕

<a href="https://www.buymeacoffee.com/bw8dwqpbd2w" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
