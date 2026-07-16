# tree-sitter-dhall

> **Provenance (fork):** forked from <https://github.com/jbellerb/tree-sitter-dhall>
> (commit `6201325`, 2025-04-13).
> **Changes vs upstream:** upstream already ships a modern `tree-sitter-language`
> `LanguageFn` Rust binding and ABI 15, so the diff is minimal: `parser.c`
> regenerated with tree-sitter-cli 0.25.10; all package versions aligned to
> `0.25.0` for this fork line (upstream is `1.0.0` — deliberate decision: this
> fork is consumed only as a git-tag dependency, and the fork-line version wins
> for cross-repo consistency; it must **never be published to crates.io/npm/PyPI
> under the upstream name**, since `0.25.0 < 1.0.0` would register as a
> downgrade — if registry publication is ever needed, use a prefixed package
> name or a version above upstream's); the empty doc-example snippet in `bindings/rust/lib.rs`
> replaced with a small valid Dhall expression; external C scanner
> (`src/scanner.c`) kept and still compiled by `bindings/rust/build.rs`;
> added a synthetic smoke-test corpus (`test/corpus_smoke/`) and
> `tests/smoke.rs`. No grammar-rule changes.
> **Depth note:** despite being described upstream as highlighting-oriented (see
> "Scope" below), the tree is not shallow — it exposes fine-grained named kinds
> (`let_expression`, `record_literal`, `union_type`, `lambda_expression`,
> `env_import`, `http_import`, `import_hash`, `interpolation`, ...). The known
> gap is semantic strictness, not depth: some invalid Dhall may still parse
> without `ERROR` nodes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[Dhall](https://dhall-lang.org/) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter)

## Scope

This parser is designed for syntax highlighting and does not strictly follow the Dhall language semantics. My goal is for all valid Dhall expressions to parse to something sensible. An invalid expression parsing is fine, except when it is obviously wrong. To help with this, the output of the parser is checked with hand-written [syntax trees](test/corpus/) for every Dhall [successful parse test](https://github.com/dhall-lang/dhall-lang/tree/master/tests/parser/success) (current with dhall-lang commit [6d4c9d6](https://github.com/dhall-lang/dhall-lang/commit/6d4c9d6b8812ed3df1f45aabeca3deaf0615ba7b)) except:

- unit/ShebangA.dhall, unit/ShebangNixA.dhall: Handled by the text editor.
- unit/TrailingLineCommentWithoutNewlineA.dhall: Unclear how to test with tree-sitter.

Additionally, these tests serve as a reference for what syntax trees various Dhall expressions produce. A shell script ([tests.sh](tests.sh)) is provided to check that all tests, excluding a few intentionally non-compliant ones, are included.

## References

- [The Dhall Syntax Grammar](https://github.com/dhall-lang/dhall-lang/blob/master/standard/dhall.abnf) - Dhall syntax is specified as an ABNF grammar based on RFC 5234.
- [The Dhall Acceptance Tests](https://github.com/dhall-lang/dhall-lang/tree/master/tests) - Tests provided by the Dhall authors to verify implementation correctness. The binary format parsing tests evaluate to is described [here](https://github.com/dhall-lang/dhall-lang/blob/master/standard/binary.md).
- [Dhall Semantics](https://github.com/dhall-lang/dhall-lang/blob/master/standard) - The complete specification of the dhall language, which all implementations are based on.

<br />

#### License

<sup>
Copyright (C) jae beller, 2022.
</sup>
<br />
<sup>
Released under the <a href="LICENSE">MIT License</a>. Test scenarios in <a href="test/corpus/">test/corpus/</a> are copyright the Dhall authors and reproduced under the <a href="LICENSE.dhall-lang">BSD-3-Clause License</a>.
</sup>

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
