# tree-sitter-rbs

> **Provenance (fork):** forked from <https://github.com/joker1007/tree-sitter-rbs>
> (commit `5282e2f`, 2025-11-14).
>
> **Why this fork:** the upstream grammar errors on ~28% of the canonical
> [`ruby/rbs`](https://github.com/ruby/rbs) signature files (`core/`, `stdlib/`,
> `sig/`). This fork fixes the grammar bugs responsible for the bulk of those
> failures and modernizes the packaging.
>
> **Grammar changes vs upstream** (see `grammar.js`):
> 1. **Method-level bounded type parameters.** `def x: [T < Numeric] (T v) -> T`
>    now parses. Upstream accepted a bound (`< Type`) only on *class/module/interface*
>    type parameters; method type parameters accepted only bare names. A new
>    `method_type_parameter` rule (inlined, so the tree shape is unchanged for the
>    unbounded case) mirrors the class-level bound. Per the RBS grammar, variance
>    (`out`/`in`) and `unchecked` remain declaration-only and are intentionally not
>    accepted on method type parameters.
> 2. **Bang (destructive) method names.** `def sort!:`, `def map!:` etc. now parse
>    via a new `identifier_bang` alternative in `method_name`, mirroring the existing
>    `?`-predicate suffix. This was the single largest cause of real-file failures.
> 3. **`!=` operator method name.** Added to the `operator` rule (it was missing).
> 4. **Backtick operator method.** The backtick method name (Ruby's `` ` ``, as in
>    `def self?.` followed by a backtick and `: (String) -> String`) no longer
>    derails: the backtick-quoted method-name token is restricted to a single line
>    (`` /`[^`\n]+`/ ``) so it can no longer greedily swallow the rest of the file
>    looking for a closing backtick. This alone repaired a cascade that corrupted
>    `core/kernel.rbs` from line 147 to 1601.
>
> **Effect on `ruby/rbs` (342 files across `core/`, `stdlib/`, `sig/`):**
> files containing an `ERROR`/`MISSING` node dropped from **95 (27.7%) to 49 (14.3%)**.
> The upstream `tree-sitter test` corpus still passes **133/133 (100%)**; the AST
> shape is unchanged for all previously-passing inputs.
>
> **Packaging changes:** `parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 15); Rust crate moved to `edition = "2021"`, `tree-sitter` demoted to a
> dev-dependency (binding uses the `tree-sitter-language` `LanguageFn` API);
> added a real-shaped smoke corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
>
> **Known remaining gaps** (unrelated to the fixes above; documented, not fixed):
> - Comment lines that are ASCII tables/art *at the top level before any
>   declaration* (e.g. a file that opens with `#     |------|-----|`) can still
>   produce local `ERROR` nodes. The pipe-continuation prefix `# |` must
>   out-precedence the `comment` token for the upstream multi-line inline
>   continuation tests to pass, which is the same reason it captures table
>   borders. A clean fix would regress those upstream tests, so this is left as a
>   gap. Table/art comments **inside** a class or module body (the common case,
>   e.g. method doc comments) parse cleanly and are covered by the smoke corpus.
> - Annotations (`%a{...}`) immediately preceding a *nested* class/module/interface
>   declaration are not accepted (nested declarations lack the annotation wrapper
>   that top-level declarations and members have).
> - Integer *literal types* with a leading minus (`-1 | 0 | 1`), type-parameter
>   *defaults* (`[T = untyped]`), and the malformed annotation-text regexes for the
>   `%a[...]`, `%a|...|`, `%a<...>` bracket styles are pre-existing upstream issues
>   left untouched.
>
> **Rebase policy:** grammar + binding diff, rebased onto upstream when it moves;
> the grammar fixes should be offered upstream.
> **Upstream PR:** pending (link will be added here once opened).

[![Build/test](https://github.com/joker1007/tree-sitter-rbs/actions/workflows/ci.yml/badge.svg)](https://github.com/joker1007/tree-sitter-rbs/actions/workflows/ci.yml)

[rbs](https://github.com/ruby/rbs) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

syntax reference is https://github.com/ruby/rbs/blob/master/docs/syntax.md

## Use this in Neovim

this parser is supported in nvim-treesitter. (https://github.com/nvim-treesitter/nvim-treesitter/pull/5745)

Please run `:TSInstall rbs`

## If you want to use specific version in Neovim

Please write it to neovim config.

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").rbs.install_info.revision = "<commit sha1>"
  end,
})
```

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
