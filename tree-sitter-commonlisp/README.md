# tree-sitter-commonlisp (fork)

> **Provenance (fork):** forked from <https://github.com/theHamsta/tree-sitter-commonlisp>
> (commit `3232350`, 2025-03-16).
> **Changes vs upstream:** parser.c regenerated with CLI 0.25.10 (ABI 14 -> 15;
> grammar.js extends tree-sitter-clojure via npm at generate time — consumers
> unaffected); version aligned to 0.25.0, dev-dep pinned 0.25, edition 2021. NOTE: the
> language constant is `LANGUAGE_COMMONLISP`; added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-
> commonlisp` kept verbatim. Upstream corpus: 43/43; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-commonlisp

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-commonlisp)
[![crates][crates]](https://crates.io/crates/tree-sitter-commonlisp)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-commonlisp)

WIP. Goal is to have a better syntax highlighting for Neovim
and some semantic refactoring https://github.com/nvim-treesitter/nvim-treesitter-refactor/.

All praise goes to https://github.com/sogaiu/tree-sitter-clojure which is extended by this grammar.

TODOs:

- support number literals that are different from clojure (e.g. `.9`)

Macros with special respresentation in syntax tree (when written with lowercase letters):

- defun and friends (e.g. defmethod)
- loop macro

This grammar is used in https://github.com/Wilfred/difftastic to generate syntax-ware diffs for Common Lisp.

## Usage

- C/C++
   - compilation run `make` (optional `make install`)
   - Follow the [Guide on using tree-sitter parsers](https://tree-sitter.github.io/tree-sitter/using-parsers/1-getting-started.html#getting-started)
   - set `tree_sitter_commonlisp()` as language on your Tree-Sitter parser from [`tree_sitter_commonlisp.h`](https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/blob/4d2a2247bb0ec117193ef33e3ce546a6781c5bf5/bindings/c/tree-sitter-commonlisp.h#L10-L10)
    ```c
    ts_parser_set_language(parser, tree_sitter_commonlisp());
     ```

- Python (`pip install tree-sitter-commonlisp tree-sitter`)
  https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/blob/4d2a2247bb0ec117193ef33e3ce546a6781c5bf5/bindings/python/tests/test_import.py#L15-L23
- Rust `cargo add tree-sitter tree-sitter-grammars`
  https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/blob/4d2a2247bb0ec117193ef33e3ce546a6781c5bf5/bindings/rust/lib.rs#L47-L50
- Swift
  https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/blob/4d2a2247bb0ec117193ef33e3ce546a6781c5bf5/bindings/swift/TreeSitterCommonlispTests/TreeSitterCommonlispTests.swift#L3-L13
- Go
  https://github.com/tree-sitter-grammars/tree-sitter-commonlisp/blob/4d2a2247bb0ec117193ef33e3ce546a6781c5bf5/bindings/go/binding_test.go#L1-L15

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-commonlisp/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-commonlisp?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-commonlisp?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-commonlisp?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
