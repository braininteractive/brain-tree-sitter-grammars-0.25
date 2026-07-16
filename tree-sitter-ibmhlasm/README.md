tree-sitter-ibmhlasm
====================

> **Provenance (fork):** forked from <https://github.com/janus-llm/tree-sitter-ibmhlasm>
> (commit `5f7ef6f2c4628f46fb5155eb1ac59df5e8de8ee6`, 2024-03-23; MITRE,
> upstream targeted tree-sitter-cli 0.20.8 / ABI 13-14, WIP).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`) — upstream's Cargo.toml pointed at a
> `bindings/rust/lib.rs` that did not exist, so this file is new; `tree-sitter`
> moved to a dev-dependency; `parser.c` regenerated with tree-sitter-cli
> 0.25.10 (ABI 15); added `tree-sitter.json` (required by the 0.25 CLI for
> ABI-15 generation); fixed the `repository` field (upstream carried the
> `tree-sitter/tree-sitter-ibmhlasm` template placeholder); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> Upstream's own test corpus is kept verbatim under `corpus/`.
> **Grammar extension:** added HLASM macro support — `MACRO`/`MEND` definitions,
> macro prototypes/parameters, `&SYMBOL` variable symbols, `.SEQ` sequence symbols,
> and conditional assembly (`SET*`, `AIF`, `AGO`, `ANOP`).
> **Bug fix (scanner):** the external scanner's continuation-line reader looped forever
> at end of input — `while (iswspace(lexer->lookahead) == 0)` never exits at EOF
> (`iswspace(0)` is false and `advance()` can't move past EOF), so any HLASM ending with a
> non-blank in column 72 (continuation expected, no next line) hung the parser indefinitely.
> Added `lexer->eof(lexer) == 0` guards to the three affected loops; the parser now always
> terminates. Regression test `test/corpus_smoke/13_continuation_at_eof.hlasm` added.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

## Overview

IBM HLASM grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

This is still a WIP - there may be bugs, and not all features are supported (macros, etc.)

The grammar models a program as a flat sequence of `comment` lines (`*` in
column 1) and `instruction` lines (`name` / `operation` / `operands` /
`remark`), with an external scanner (`src/scanner.c`) handling
column-sensitive names, comments and continuation lines. Assembler
directives (CSECT, DSECT, DC, DS, EQU, USING, END, ...) are parsed as
ordinary `operation` nodes — there are no directive-specific nodes.

## GAPS (inherited from upstream — intentionally not fixed in this fork)

* **Macro support is basic** (added in this fork; see provenance above):
  `MACRO`/`MEND` definitions, prototypes/parameters, `&SYMBOL` variable symbols,
  `.SEQ` sequence symbols, and `SET*`/`AIF`/`AGO`/`ANOP` conditional assembly are
  parsed, but deep macro-expansion semantics and nested macro edge cases are not
  modeled. Macro *invocations* that look like plain instructions still parse as
  generic instruction nodes.
* **Column-format edge cases**: some column-72 continuation / cols-73–80 sequence-number
  combinations still produce ERROR nodes (a torture-test file reports ~17). The parser
  always terminates (the prior infinite-hang bug is fixed), but full column-format
  fidelity is incomplete.
* **No operand sub-structure**: `operands` is a single flat token; register
  lists, displacements `12(13)`, literals `=C'...'` / `=X'...'` and
  expressions are not broken into child nodes. Character and hex literals
  (`C'HELLO'`, `X'0A0B'`, quoted strings with spaces) are only recognized
  inside the flat `operands` token via the scanner's quote tracking.
* **No directive semantics**: CSECT/DSECT/DC/DS/EQU/USING/END etc. are
  indistinguishable from machine instructions in the tree (all are
  `operation`).
* **Trailing-newline quirk**: the `program` rule cannot end with a single
  trailing newline; a file ending in `\n` yields a zero-width `MISSING
  _newline` node at EOF. It is a hidden node (invisible to cursor
  traversal and to the CLI's s-expression output) but it does set
  `has_error()` on the root node. Strip the final newline for a
  fully clean tree. Upstream's own corpus notes a related EOF TODO.
* Operations are restricted to `[A-Za-z0-9]+`; opcodes or labels containing
  `#`, `$`, `@` or `_` (all legal in HLASM) mis-parse.
* No ICTL/sequence-field handling (columns 73-80 are treated as content,
  triggering continuation logic at column 72 only).

## Smoke corpus

`test/corpus_smoke/` contains 12 synthetic HLASM samples written for this
fork (labels, machine instructions, assembler directives, comments,
continuation lines, remarks, DSECT layouts, character/hex literals,
register equates). All 12 parse with a 0% error/missing-node ratio
(`tests/smoke.rs` enforces < 5%).

### Copyright
Copyright ©2024 The MITRE Corporation. ALL RIGHTS RESERVED. Approved for Public Release; Distribution Unlimited. Public Release Case Number 23-4084.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
