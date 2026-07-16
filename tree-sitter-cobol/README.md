# tree-sitter-cobol

> **Provenance (fork):** forked from <https://github.com/yutaro-sakamoto/tree-sitter-cobol>
> (commit `e99dbdc`, 2024-12-17).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added a `tree-sitter.json` manifest (required by tree-sitter-cli 0.25 to emit ABI 15);
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`, fixed-format sources) and `tests/smoke.rs`.
> No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).
>
> **Known gaps / notes:**
>
> - Sources must be **fixed-format** (code in area A/B starting at column 8; the
>   external scanner interprets columns 1-6 as the sequence area and column 7 as
>   the indicator area). Free-format COBOL is not supported.
> - COBOL-85 feature set (NIST-suite oriented); modern OO COBOL (2002+) syntax,
>   `EXEC SQL`/CICS embedded blocks, and vendor extensions are not covered.
> - The Rust crate is named `tree-sitter-cobol` (lowercase, fixed at publish —
>   upstream's `tree-sitter-COBOL` casing made cargo warn). The C symbol stays
>   `tree_sitter_COBOL` (baked into the generated parser and external scanner;
>   kept verbatim to stay rebasable on upstream).

COBOL85 grammar of [tree-sitter](https://github.com/tree-sitter/tree-sitter)

The syntax rules of tree-sitter-cobol are based on [opensource-cobol](https://github.com/yutaro-sakamoto/opensource-cobol)
and are tested with [NIST COBOL85 test suite](https://www.itl.nist.gov/div897/ctg/cobol_form.htm)

## How to run with latest Nodejs Version(v20.10.0)

```bash
# Change Nodejs Version to latest
nvm use 20

# Remove modules if already generated and package-lock.json file
rm -rf node_modules package-lock.json

npm install

npm rebuild --update-binary
```

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
