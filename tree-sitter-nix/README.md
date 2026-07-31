# tree-sitter-nix (fork)

> **Provenance (fork):** forked from <https://github.com/nix-community/tree-sitter-nix>
> (commit `3d0173d903e630b6e14d17f1cf79488791379ded`, 2026-06-25).
> **Changes vs upstream:** `parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 13 -> 15); crate version aligned to `0.25.0` for this fork line (upstream is
> `0.3.0`); `tree-sitter` dev-dependency pinned `>=0.23` -> `0.25`; edition 2018 -> 2021;
> upstream parse corpus moved `corpus/` -> `test/corpus/` (CLI 0.25 layout); added a
> synthetic smoke-test corpus (`test/corpus_smoke/`, 12 files: attrsets, let/in, functions,
> mkDerivation, flakes, conditionals, strings/indented strings, lists, with/inherit,
> operators, recursion, NixOS modules) and `tests/smoke.rs`. External C scanner kept
> verbatim. No grammar-rule changes. Package name `tree-sitter-nix` kept verbatim.
> Upstream parse corpus: 54/54; smoke corpus: 0.00% error nodes. Known: one pre-existing
> upstream *highlight-query* test failure (`property` vs `variable` capture naming) — a
> queries issue, not a parse issue, kept as-is.
> **Rebase policy:** regen/tests diff, rebased onto upstream when it moves; retired if
> upstream publishes an equivalent 0.25-line crate.
> **Upstream PR:** pending (regen + corpus layout are upstream-PR material).

# tree-sitter-nix

[![Build Status](https://github.com/nix-community/tree-sitter-nix/actions/workflows/nix-github-actions.yml/badge.svg)](https://github.com/nix-community/tree-sitter-nix/actions/workflows/nix-github-actions.yml)

Nix grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
