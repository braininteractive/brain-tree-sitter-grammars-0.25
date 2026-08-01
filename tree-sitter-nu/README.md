# tree-sitter-nu (fork)

> **Provenance (fork):** forked from <https://github.com/nushell/tree-sitter-nu>
> (commit `9467420d184bd2c510378f4cda624eca35dd4590`, 2026-07-28).
> **Changes vs upstream:** pin-style — official Nushell grammar, already ABI 15 +
> LanguageFn (scanner kept verbatim); version aligned to 0.25.0; added a synthetic
> smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus:
> 312/312; smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# Tree-sitter grammar for Nushell

[**WIP**] [nushell](https://github.com/nushell/nushell) grammar for [tree-sitter](https://tree-sitter.github.io/tree-sitter/)

## goals (brainstorming)

- Ability to serve as a parser for a repl
- Ability to work in editors that support tree-sitter (`hx`, `nvim`, others)
- Ability to work in rust
- Fast
- Ability to be utilized for syntax highlighting
- ...

## installation guide
- for *neovim* users, please have a look at [`installation/neovim.md`](installation/neovim.md)
- for *helix* users, please have a look at [`installation/helix.md`](installation/helix.md)

## contributing
see [instructions](./CONTRIBUTING.md)


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
