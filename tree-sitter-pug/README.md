# Tree-sitter-pug

> **Provenance (fork):** forked from <https://github.com/zealot128/tree-sitter-pug>
> (commit `13e9195`, 2024-11-17).
> **Changes vs upstream (migration to tree-sitter 0.25 / ABI 15):**
>
> - Added `tree-sitter.json` (required by tree-sitter-cli 0.25 to generate at ABI 15).
> - Regenerated `src/parser.c` with tree-sitter-cli 0.25.10: ABI 14 → 15; updated
>   `src/tree_sitter/parser.h` and added the new `src/tree_sitter/alloc.h` /
>   `src/tree_sitter/array.h` runtime headers.
> - `grammar.js`: **zero changes** — all 653 lines survived `tree-sitter generate`
>   0.25.10 unchanged, and all 90 upstream corpus tests (`tree-sitter test`) still pass.
> - `src/scanner.c`: **zero changes** — it already used the modern
>   `tree_sitter_pug_external_scanner_{create,destroy,scan,serialize,deserialize}`
>   signatures and current `TSLexer` API (`advance`, `mark_end`, `get_column`,
>   `result_symbol`), so no scanner port was needed.
> - `Cargo.toml`: version `0.0.1` → `0.25.0`, edition `2018` → `2021`; Rust binding
>   moved to the `tree-sitter-language` `LanguageFn` API (`tree-sitter-language = "0.1"`
>   dependency, `tree-sitter = "0.25"` as dev-dependency only); fixed the `repository`
>   field, which upstream had left pointing at `tree-sitter/tree-sitter-javascript`.
> - `bindings/rust/lib.rs`: rewritten to export `pub const LANGUAGE: LanguageFn`
>   (the old `pub fn language() -> Language` is removed); keeps `NODE_TYPES` and
>   `HIGHLIGHTS_QUERY`.
> - `bindings/rust/build.rs`: now compiles `src/scanner.c` — upstream shipped the
>   template with the external-scanner block commented out, so the crate could never
>   have linked against its own scanner.
> - Node binding rebuilt: `nan`-based `binding.cc` replaced with `node-addon-api`
>   (napi) + `node-gyp-build` loader; `binding.gyp` fixed to compile `src/scanner.c`
>   (upstream listed a non-existent `src/scanner.cc`).
> - `package.json`: modernized deps/scripts for CLI 0.25; `license` corrected from
>   `ISC` to `MIT` to match the repository's `LICENSE` file (and upstream's Cargo.toml).
> - Added a 12-file synthetic smoke corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
>
> **No grammar-rule changes**: the language definition is upstream's, byte for byte.
> **Rebase policy:** toolchain/binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

This is a general tree-sitter parser grammar for the [pug](https://github.com/pugjs/pug) language with some extra features built in for Angular and Vue development.

## Current state

Everything currently included is relatively bug-free, but the structure/name of some rules may change before we declare this parser "complete".

There is list of todos at the top of `grammar.js`, but the summary is: all of the basics are supported.
There are tests for every scenario supported, so you can just have a look through `./test/corpus/*.txt` to see exactly which scenarios are supported and have been tested.

Feel free to open an issue/pull request if there's something missing/broken.

## Developing

How to run & test:

```
npm install -g tree-sitter-cli
tree-sitter generate && tree-sitter test
```


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
