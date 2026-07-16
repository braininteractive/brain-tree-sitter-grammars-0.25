# tree-sitter-jsdoc

> **Provenance (fork):** forked from <https://github.com/tree-sitter/tree-sitter-jsdoc>
> (commit `658d18dcdddb75c760363faa4963427a7c6b52db`, 2025-09-13).
> **Bug fixed vs upstream — bare runnable-code `@example` bodies:** upstream tries to
> parse a bare `@example` body (arbitrary JS: `//` comments, `=>`, semicolons, multiple
> lines) as structured content and produces `ERROR` nodes. Measured against verbatim
> `/** ... */` blocks extracted from [lodash][]'s `lodash.js`, this affected **46.2% of
> all doc comments (314/680)** and **99.7% of blocks containing `@example` (305/306)**.
> **The fix:** the `@example` body is now an opaque free-text region, scanned by the
> external scanner (`example_body` token in `src/scanner.c`), that tolerates arbitrary
> code up to the next `@tag` or the closing `*/`. A leading fenced code block (```` ``` ````)
> still parses as a structured `description`/`code_block` (the scanner defers in that case),
> so upstream code-block behavior is preserved. Structured tags (`@param`, `@returns`,
> `@type`, `@typedef`, `@name`, ...) are unchanged.
> **Result:** the `@example` repro parses with 0 errors; the lodash block-error rate drops
> from **46.2% to 6.9%**, and `@example`-body errors drop from **99.7% to 0%**. The residual
> 6.9% are unrelated `@param`/`@params` default-value expressions (e.g. `[string='']`,
> `[options={}]`, `[fromIndex=array.length-1]`) that upstream also fails on — out of scope
> for this fix.
> **Grammar changes:** `grammar.js` — added the external `example_body` token, a dedicated
> `@example` tag alternative (`tag_name_example`), and routed its body to
> `optional(choice(description, example_body))`. `src/scanner.c` — added `scan_example_body`.
> One upstream corpus expectation (`test/corpus/braces.txt` "Unmarked code example") was
> updated from `(description)` to `(example_body)` to reflect the new opaque parse; all
> 17 upstream corpus tests pass. `parser.c` regenerated with tree-sitter-cli 0.25.10
> (ABI 15). Added `test/corpus_smoke/` (12 full JSDoc comments) and `tests/smoke.rs`.
> The Rust binding already uses the `tree-sitter-language` `LanguageFn` API with
> `tree-sitter` as a dev-dependency (unchanged).
> **Note:** jsdoc is an injection grammar (`file-types` is `null`); it is embedded in
> JS/TS comments in normal use. The smoke test parses standalone `/** ... */` blocks.
> **Rebase policy:** rebased onto upstream when it moves; retired if upstream ships an
> equivalent `@example` fix.
> **Upstream PR:** pending (link will be added here once opened).

[lodash]: https://github.com/lodash/lodash

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.

[![CI][ci]](https://github.com/tree-sitter/tree-sitter-jsdoc/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-jsdoc)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-jsdoc)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-jsdoc)

[JSDoc](<(https://jsdoc.app/)>) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter/tree-sitter-jsdoc/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-jsdoc?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-jsdoc?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-jsdoc?logo=pypi&logoColor=ffd242
