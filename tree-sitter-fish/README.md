tree-sitter-fish
================

> **Provenance (fork):** forked from <https://github.com/ram02z/tree-sitter-fish>
> (commit `f435b0b`, 2026-04-16).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added `tree-sitter.json` (required by tree-sitter-cli 0.25 for ABI 15);
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); the external
> scanner (`src/scanner.c`) is unchanged and still compiled by `build.rs`; added a
> synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

Fish grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

### Development

Install the dependencies:

    npm install

Run the tests:

    npm run test

Run the build and tests in watch mode:

    npm run test:watch

Test parser against [fish-shell](https://github.com/fish-shell/fish-shell/tree/master/share) `/share` fish files:

    npm run test:examples

#### References
* [tree-sitter-bash](https://github.com/tree-sitter/tree-sitter-bash)
* [Fish Shell Introduction](https://fishshell.com/docs/current/index.html)

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
