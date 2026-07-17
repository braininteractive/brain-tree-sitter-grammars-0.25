# tree-sitter-nim (fork)

> **Provenance (fork):** forked from <https://github.com/alaviss/tree-sitter-nim>
> (commit `ac72ba30d16edf0be021588a9301ede4accd6cf4`, 2026-07-03).
> **Changes vs upstream:** upstream is actively maintained but publishes **no crates.io
> release** and shipped a legacy `pub fn language()` Rust binding with `tree-sitter ~0.25`
> as a hard dependency. This fork: `parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 14 -> 15); `bindings/rust/lib.rs` rewritten to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `Cargo.toml`: `tree-sitter-language = "0.1"`
> in dependencies with `tree-sitter = "0.25"` dev-only, version `0.25.0` (fork line),
> edition 2021, repository URL corrected to the actual upstream, `tree-sitter.json`
> packaged; added a synthetic smoke-test corpus (`test/corpus_smoke/`, 12 files) and
> `tests/smoke.rs`. External C scanner kept verbatim. No grammar-rule changes.
> License: MPL-2.0 (upstream, preserved; binding scaffold files carry their original
> MIT/CC0 SPDX headers).
> Upstream corpus: 74/74; smoke corpus: 0.00% error nodes.
> **Rebase policy:** binding/regen/tests diff, rebased onto upstream when it moves;
> retired if upstream publishes an equivalent 0.25-line crate.
> **Upstream PR:** pending (LanguageFn binding modernization is upstream-PR material).

<!--
SPDX-FileCopyrightText: None

SPDX-License-Identifier: CC0-1.0
-->

# Tree sitter grammar for Nim

A [tree-sitter] grammar for [Nim].

The goal is to parse a superset of Nim and create a syntax tree that can be
easily ingested by tools.

## Notes

Generating this parser take around 7GiB of memory. Any help in reducing
the parser size is appreciated.

## Progress

Right now the parser is capable of parsing all of Nim, with exceptions for old
and mostly unused/dead syntax, including:

- Package-level objects (ie. `type X.Y = ref Z`)

- Variable declaration with dots for "partial" objects (ie. `let x.y = z`).

- Covariance in generics for imported types (ie. `type X[out T] = Z`).

These were omitted due as they are a product of old language experiments that
never caught on, and omitting them allows for simpler and more compact parser,
but support might be added on request.

The parser correctness has not been thoroughly tested.

## Stability

Node names and structures are not expected to change between releases.

## License

The project is licensed under the [Mozilla Public License version 2.0][MPL]

[tree-sitter]: https://github.com/tree-sitter/tree-sitter
[Nim]: https://github.com/nim-lang/Nim
[MPL]: https://www.mozilla.org/en-US/MPL/2.0/


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
