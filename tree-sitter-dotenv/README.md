# tree-sitter-dotenv (fork)

> **Provenance (fork):** forked from <https://github.com/pnx/tree-sitter-dotenv>
> (commit `8b1dad881974a7c1a7e3cb1f55b3a9b38ddec3ec`, 2026-07-22).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0. Two upstream corpus tests use the `:cst` attribute (a CLI 0.26 feature) and
> fail under the 0.25 harness — export parsing itself verified clean by the smoke
> corpus. `${VAR}` interpolation is supported inside double quotes; added a synthetic
> smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus:
> 7/7 (+2 :cst-gated); smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-dotenv

tree-sitter grammar for [dotenv](https://dotenvx.com)

## Installation

[neovim](docs/neovim.md)

## Author

Henrik Hautakoski <henrik.hautakoski@gmail.com>


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
