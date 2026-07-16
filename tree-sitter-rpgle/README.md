tree-sitter-rpgle
=================

> **Provenance (extraction + fork):** extracted from
> <https://github.com/mayflower/rpg-explainer> (repo HEAD commit
> `a1a89602db00873981d7b7ee548cae002feb9ef5`, 2025-12-04), path
> `tree-sitter-rpg/` (embedded grammar, upstream targeted tree-sitter-cli
> 0.24 / ABI 14). `grammar.js` is taken **verbatim from upstream commit
> `718f7d5` ("Initial implementation of RPG Explainer tool")**, the last
> buildable revision: the HEAD revision of `grammar.js` (added in `503abaf`)
> declares 8 external-scanner tokens for fixed-form specs, but the required
> `src/scanner.c` was **never committed anywhere in upstream's history**, so
> the HEAD grammar cannot be compiled or linked. The delta between `718f7d5`
> and HEAD is exactly that external-scanner plumbing and nothing else.
> **Changes vs upstream:** standalone repo layout (Cargo.toml,
> `bindings/rust/`, `tree-sitter.json`); Rust binding uses the modern
> `tree-sitter-language` `LanguageFn` API (`pub const LANGUAGE`);
> `tree-sitter` is a dev-dependency only; `src/parser.c` generated with
> tree-sitter-cli 0.25.10 (ABI 15); added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> LICENSE copied verbatim from the upstream repo root (the embedded grammar
> directory has no license file of its own; its `package.json` also says MIT).
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships a standalone 0.25 grammar (with its scanner).
> **Upstream PR:** pending (link will be added here once opened).

IBM ILE RPG (free-form RPGLE) grammar for [tree-sitter][].

[tree-sitter]: https://github.com/tree-sitter/tree-sitter

The grammar is deliberately coarse ("simplified version with minimal
ambiguity", per upstream): statements are largely token soups terminated by
`;`, with structural rules for declarations (`dcl-s`, `dcl-c`, `dcl-ds`,
`dcl-f`, `dcl-pr`, `dcl-pi`, `dcl-proc`) and control flow (`if`, `dow`,
`dou`, `for`, `select`, `monitor`).

## Known gaps

* **No fixed-form RPG support.** Upstream's README claims fixed-form
  (H/F/D/C/P specs) support via an external scanner, but `scanner.c` was
  never committed to the upstream repository, so the claim is unverifiable
  and the fixed-form grammar revision is unbuildable. Fixed-form source
  mis-parses badly here (a 5-line H/F/D/C probe produced ERROR/MISSING
  nodes and a failed parse) and is intentionally excluded from the smoke
  corpus.
* **`**FREE` marker:** parses without ERROR nodes, but is tokenized as
  `*`, `*FREE` inside a `simple_statement` that also absorbs the following
  statement's tokens (statements are `;`-terminated and the marker line has
  no `;`). Structure after the first `;` is unaffected. There is no
  dedicated node for the marker.
* `/COPY`, `/FREE`, `/IF` etc. are single flat `preprocessor_directive`
  tokens; included members are not expanded.
* No embedded SQL (`EXEC SQL`) support.
* Expressions are flat token sequences (`_token*`): no operator precedence,
  no call/expression tree inside statements.

## Smoke corpus

`test/corpus_smoke/` contains 12 synthetic free-form RPGLE samples written
for this fork (declarations, data structures, control flow, procedures,
prototypes, `ctl-opt`, file I/O, built-ins, compiler directives). All 12
parse with a 0% error/missing-node ratio (`tests/smoke.rs` enforces < 5%).

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
