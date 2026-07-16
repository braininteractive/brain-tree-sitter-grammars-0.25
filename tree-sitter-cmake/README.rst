==============================
A Tree-sitter parser for CMake
==============================

.. note:: **Provenance (fork):** forked from https://github.com/uyha/tree-sitter-cmake
   (commit ``ca627bb``, 2026-07-08), pinned for reproducible builds.
   **Upstream status:** already 0.25-clean — modern ``tree-sitter-language``
   ``LanguageFn`` Rust binding and ``parser.c`` at ABI 14 (loads on the 0.25 runtime);
   verified against tree-sitter 0.25 with tree-sitter-cli 0.25.10. No binding or
   grammar changes were needed.
   **Changes vs upstream:** added a synthetic smoke-test corpus
   (``test/corpus_smoke/``, 12 CMake files) and ``tests/smoke.rs`` only.
   **Rebase policy:** test-only diff, rebased onto upstream when it moves; retired if
   the pin is no longer needed.
   **Upstream PR:** pending (link will be added here once opened).

This project provides a `cmake` parser. Its primary use case is to provide a `cmake`
parser for `nvim-treesitter`.

Parsed syntax
=============

- Command

  - General commands
  - For and while loops
  - If conditions
  - Functions and macros

- Arguments

  - Quoted arguments
  - Bracket arguments
  - Unquoted arguments
  - Parentheses

- Variable references

  - Environment and cache variables
  - Normal variables


Maintenance & support
---------------------

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source.
