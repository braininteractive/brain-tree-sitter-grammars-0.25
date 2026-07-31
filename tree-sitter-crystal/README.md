# tree-sitter-crystal (fork)

> **Provenance (fork):** forked from <https://github.com/crystal-lang-tools/tree-sitter-crystal>
> (commit `50ca9e6fcfb16a2cbcad59203cfd8ad650e25c49`, 2025-10-12).
> **Changes vs upstream:** pin-style fork — upstream already ships ABI 15 `parser.c`
> (regenerated upstream with CLI 0.25.10), `tree-sitter.json`, and a modern
> `tree-sitter-language` `LanguageFn` Rust binding. Diff is minimal: crate version aligned
> to `0.25.0` for this fork line; `tree-sitter` dev-dependency bumped 0.24.4 -> 0.25
> (upstream's own load-test could not load its ABI-15 parser — upstream-note material);
> added a synthetic smoke-test corpus (`test/corpus_smoke/`, 12 files: classes/structs,
> generics, blocks/procs, union types, exceptions, macros, enums, heredocs, spawn/channels,
> lib/annotations) and `tests/smoke.rs`. External C scanner kept verbatim. No grammar-rule
> changes. Package name `tree-sitter-crystal` kept verbatim.
> Upstream corpus: 254/254; smoke corpus: 0.00% error nodes.
> **Rebase policy:** tests-only diff, rebased onto upstream when it moves; retired if
> upstream publishes an equivalent 0.25-line crate.
> **Upstream PR:** pending (dev-dep bump is upstream-PR material).

# tree-sitter-crystal

[Crystal](https://crystal-lang.org/) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

This grammar is mostly complete, and can parse the majority of Crystal's own source code without errors.

## Setup

Hopefully support for this parser will be upstreamed by editors soon. At the moment, it must be integrated manually.

### Neovim

0. Set up the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main) plugin.

#### For nvim-treesitter v0.10 or newer (recommended)

1. Include this lua snippet in your neovim setup:

   ```lua
   vim.api.nvim_create_autocmd("User", {
     pattern = 'TSUpdate',
     callback = function()
       require('nvim-treesitter.parsers').crystal = {
         install_info = {
           url = 'https://github.com/crystal-lang-tools/tree-sitter-crystal',
           -- path = '<ts-crystal-install-path>', -- if you want to use a local version instead
           generate = false,
           generate_from_json = false,
           queries = 'queries/nvim'
         },
       }
     end,
   })

   vim.treesitter.language.register("crystal", { "cr" })
   ```

2. Restart neovim and run `:TSUpdate`

To confirm the grammar is functioning, run `:checkhealth nvim-treesitter` and look for this line:

```
- crystal             ✓ . ✓ . ✓
```


#### For older nvim-treesitter versions (aka the master branch)

1. Check out this repo locally. Its location will be referred to as `<ts-crystal-install-path>`.
2. In a terminal, navigate to wherever nvim-treesitter is installed (this will depend on your plugin manager). Run:

   ```bash
   mkdir queries/crystal
   cd queries/crystal
   ln -s <ts-crystal-install-path>/queries/nvim/*.scm .
   ```

3. Include this lua snippet in your neovim setup:

   ```lua
   local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
   parser_config.crystal = {
     install_info = {
       url = "<ts-crystal-install-path>",
       files = {"src/parser.c", "src/scanner.c"},
       branch = "main",
     },
     filetype = "cr",
   }
   ```

4. Restart neovim and run `:TSInstall crystal`


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
