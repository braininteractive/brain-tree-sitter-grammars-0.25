tree-sitter-vyper
==================

> **Provenance (fork):** forked from <https://github.com/madlabman/tree-sitter-vyper>
> (commit `e4d43a8`, 2023-05-09).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15; a minimal
> `tree-sitter.json` was added because the 0.25 CLI requires it for ABI 15);
> `bindings/rust/build.rs` now compiles the external scanner (`src/scanner.cc`),
> which upstream left commented out, so the Rust crate links; added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule
> changes.
> **Known limitation:** the external scanner is C++ (`scanner.cc`); tree-sitter CLI
> 0.22+ no longer compiles C++ scanners, so `tree-sitter parse`/`tree-sitter test`
> cannot load this grammar. The Rust crate is unaffected (build.rs compiles the
> scanner via `cc`). Porting the scanner to C is left to a future change.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[![build](https://github.com/madlabman/tree-sitter-vyper/actions/workflows/ci.yml/badge.svg)](https://github.com/madlabman/tree-sitter-vyper/actions/workflows/ci.yml)

Vyper grammar for [tree-sitter][].

[tree-sitter]: https://github.com/tree-sitter/tree-sitter

#### Installation

```lua
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.vyper = {
	install_info = {
		url = "https://github.com/madlabman/tree-sitter-vyper", -- local path or git repo
		files = {
			"src/parser.c",
			"src/scanner.cc",
		},
		-- optional entries:
		branch = "master", -- default branch in case of git repo if different from master
		generate_requires_npm = false, -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
	},
	filetype = "vyper", -- if filetype does not match the parser name
}
```

#### References

* [Vyper Grammar](https://github.com/vyperlang/vyper/blob/master/vyper/ast/grammar.lark)

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
