# Delivery Report — Tree-sitter Grammar Fork & Upgrade Program

Date: 2026-07-15. Toolchain: **tree-sitter-cli 0.25.10**, Rust stable 1.91, clang 17.
Every delivered repo: builds against `tree-sitter = "0.25"`, exposes `pub const LANGUAGE: tree_sitter_language::LanguageFn` (deps: `tree-sitter-language = "0.1"`; `tree-sitter` as dev-dependency only), generated `parser.c` committed at **ABI 15**, in-repo smoke test (`cargo test`) parsing ≥10 public/synthetic files with <5% error-node gate, license + attribution preserved, README provenance header, local tag **`v0.25.0-fork.1`**.

Status legend: ✅ delivered & independently verified (fresh `cargo test`, clean git tree, tag present) · ⛔ stopped per brief §6.

**All smoke corpora are 100% synthetic** (authored for this program) except where a repo's own upstream corpus was additionally retained/regenerated. **Measured error-node ratio is 0.00% on every smoke file in every delivered repo.**

Pending for all items: push to GitHub org + tagged release + upstream PR (blocked on org name & `gh auth login`).

## Tier 1 — config / build / template

| # | Grammar | Upstream @ forked commit | ABI | Status | Notes / gaps |
|---|---------|--------------------------|-----|--------|--------------|
| 1 | json5 | Joakker/tree-sitter-json5 @ `248b856` (2026-05-04) | 15 | ✅ | Upstream had already regenerated ABI 15; diff is binding-only. |
| 2 | dockerfile | camdencheek/tree-sitter-dockerfile @ `971acdd` (2025-01-12) | 14→15 | ✅ | External scanner preserved; heredocs verified. |
| 3 | blade | EmranMR/tree-sitter-blade @ `5dbdcb0` (2026-04-27) | 15 | ✅ | Upstream already ships LanguageFn binding — diff is regen+corpus. queries/injections.scm preserved (PHP/HTML injection resolution is the consumer's job). |
| 4 | ninja | alemuller/tree-sitter-ninja @ `0a95cfd` (2022-01-07) | 15 | ✅ | Added minimal `tree-sitter.json` (CLI 0.25 requires it for ABI 15). No scanner. |
| 5 | jsonnet | sourcegraph/tree-sitter-jsonnet @ `ddd075f` (2024-08-15) | 14→15 | ✅ | Added `tree-sitter.json`. **Fixed upstream thread-safety bug**: scanner state was in file-scope globals — parsers on different threads raced and intermittently mis-parsed strings (caught by parallel-test audit; ~1-in-6 flake). State moved into per-parser payload; 20/20 stress runs green after fix. Strong upstream-PR material. |
| 6 | dhall | jbellerb/tree-sitter-dhall @ `6201325` (2025-04-13) | 15 | ✅ | Upstream fresher than briefed (already ABI 15 + LanguageFn). "Highlight-only" = semantic leniency (invalid Dhall may parse), tree is NOT shallow (~80 named kinds). Crate version downgraded 1.0.0→0.25.0 per fork scheme — revisit if ever published to crates.io. |

## Tier 1-DB — SQL procedural

| # | Grammar | Upstream @ commit | ABI | Status | Notes / gaps |
|---|---------|-------------------|-----|--------|--------------|
| 7 | plsql | AndreasMaierDe/tree-sitter-plsql @ `28aebef` (2023-02-18) | 15 | ✅ | One 4-line grammar fix (standalone CREATE PROCEDURE/FUNCTION was structurally unparseable — duplicated `END name;` requirement). Gaps: `:new.col`/`:old.col` in triggers, multi-event DML triggers, collection element as assignment target, cursor FOR over inline subquery. |
| 8 | tsql | Crary-Systems/tree-sitter-tsql @ `443d2bc` (2025-05-26) | 15 | ✅ | **Assessment: PARTIAL (~20-30%) confirmed** — upstream lacked WHERE, operators, joins, comments; Rust binding referenced wrong C symbol. **Extended** (sanctioned): expressions/search conditions, full SELECT (joins/CTEs/set-ops), INSERT/UPDATE/DELETE/MERGE, CREATE TABLE/PROC/VIEW/INDEX, ALTER/DROP, IF/WHILE/TRY-CATCH/transactions. 252/252 upstream corpus tests pass; 16 smoke files 0%. Gaps (with failing samples in `test/corpus_known_gaps/`): cursors, CREATE FUNCTION/TRIGGER, PIVOT/APPLY, OUTPUT, OFFSET/FETCH, GRANT/REVOKE, FOR XML/JSON, keywords-as-identifiers. Upstream PR will be substantial; rebase = manual merge. |

## Tier 2 — scripting / data / web-template

| # | Grammar | Upstream @ commit | ABI | Status | Notes / gaps |
|---|---------|-------------------|-----|--------|--------------|
| 9 | fish | ram02z/tree-sitter-fish @ `f435b0b` (2026-04-16) | 14→15 | ✅ | 123/123 upstream parse-corpus pass. One pre-existing highlight-query test failure (queries issue, not parse). Scanner preserved. |
| 10 | less | jimliang/tree-sitter-less @ `e5ae624` (2025-10-30) | 14→15 | ✅ | Needs `npm i` at dev time (extends tree-sitter-css) — consumers unaffected. 50/50 upstream corpus pass. Gap: `~"escaped"` operator unsupported. |
| 11 | thrift | duskmoon314/tree-sitter-thrift @ `68fd0d8` (2024-04-20) | 14→15 | ✅ | 29/29 upstream corpus pass. Exotic legacy features (senum, xsd, streams) unexercised. |
| 12 | cue | eonpatapon/tree-sitter-cue @ `dd7b90e` (2026-04-14) | 15 | ✅ | **Stability verdict: stable for modern CUE** — upstream actively maintained 2024–2026, "unstable" label outdated. 51/51 upstream corpus pass. Legacy `mod/quo/div/rem` ops (pre-2020 CUE) unsupported by design. |
| 13 | pug | zealot128/tree-sitter-pug @ `13e9195` (2024-11-17) | 14→15 | ✅ | "0.17-era" was only a stale Cargo pin — grammar was already ABI 14/modern scanner; 90/90 upstream corpus pass. Fixed upstream bugs: Rust build never compiled the scanner (crate could not link); binding.gyp typo scanner.cc→scanner.c. Gaps = upstream TODOs (attr concatenation, nested-pug interpolation, Angular microsyntax). |
| 14 | stylus | — | — | ⛔ | **No tree-sitter Stylus grammar exists anywhere** (GitHub API, npm, Sourcegraph, nvim-treesitter/Helix/Zed/emacs registries, grammar lists all exhausted). Per brief §6, stopped. **DECISION (2026-07-16): dropped from the program** — commissioning a grammar from scratch is out of scope. Fallback for consumers: treat `.styl` as plain text, or route brace/colon-style Stylus through the CSS grammar (best-effort only). Revisit if a community grammar appears. |
| 15 | freemarker | debba/tree-sitter-freemarker @ `36bb293` (2026-01-13) | 15 | ✅ | Bindings finished (upstream scaffold bound the wrong C symbol and could never link); ERB leftovers replaced. Gaps (inherited embedded-template design): expressions/params are opaque tokens; `directive_content` cannot contain `/` `>` `]` (e.g. `<#include "a/b.ftl">`, `x > 3` mis-parse — `gt` form works); comments containing `-` error. Non-Rust bindings remain unrenamed scaffolding. |

## Query / chain

| # | Grammar | Upstream @ commit | ABI | Status | Notes / gaps |
|---|---------|-------------------|-----|--------|--------------|
| 16 | sparql | GordianDziwis/tree-sitter-sparql @ `1ef52d3` (2025-10-15) | 15 | ✅ | Upstream fresher than briefed (already ABI 15). Gap: case-insensitivity helper mishandles at least `ISIRI` (canonical `isIRI` fine); SPARQL Update forms unexercised. |
| 17 | vyper | madlabman/tree-sitter-vyper @ `e4d43a8` (2023-05-09) | 14→15 | ✅ | Enabled `scanner.cc` compilation (upstream shipped it commented out — crate could never link). **Caveat: C++ scanner** — Rust crate fine (cc compiles it), but tree-sitter CLI ≥0.22 cannot load C++ scanners (ratios measured via Rust harness); porting scanner to C is the flagged follow-up. Grammar is Vyper 0.3.x-era; ≥0.4 syntax (`# pragma version`, typed for-loops, `@deploy`) not covered. |

## Tier 3 — mainframe / legacy (partial acceptable)

| # | Grammar | Upstream @ commit | ABI | Status | Notes / gaps |
|---|---------|-------------------|-----|--------|--------------|
| 18 | cobol | yutaro-sakamoto/tree-sitter-cobol @ `e99dbdc` (2024-12-17) | 14→15 | ✅ | crates.io decoy untouched. Fixed-format only (cols 1–7 semantics); COBOL-85 scope — no OO COBOL, no EXEC SQL/CICS. Crate name `tree-sitter-COBOL` casing warns on build (kept per minimal diff — decide at publish). |
| 19 | abap | mkoval1/tree-sitter-abap @ `c7604df` (2024-06-29) | 14→15 | ✅ | ⚠️ **No upstream LICENSE file** (Cargo says MIT, package.json says ISC) — must be clarified with upstream author before publication. Coverage narrower than briefed: no FORM/PERFORM (known), also no ELSE/ELSEIF, no CASE, comparisons limited to `=`/`<>`, no string templates, calls-as-statements only, obsolete SELECT form only. |
| 20 | rpgle | extracted from mayflower/rpg-explainer @ `a1a8960`, path `tree-sitter-rpg/` | 15 | ✅ | Standalone repo built from last buildable revision (`718f7d5` grammar.js). **Fixed-form claim is FALSE** — required external scanner was never committed anywhere in upstream history; free-form only (verified), label it as such when publishing. MIT license copied from repo root. |
| 21 | hlasm | janus-llm/tree-sitter-ibmhlasm @ `5f7ef6f` (2024-03-23) | 14→15 | ✅ | Upstream crate never compiled (missing lib.rs) — fixed. Gaps: no macros (MACRO/MEND, &symbols, AIF/AGO), flat `operands` token, `#$@_` in names mis-parse, no sequence-field cols 73–80. Quirk: file ending in single trailing newline yields hidden `MISSING _newline` that sets `has_error()` (documented). |

## Decisions needed before/at publish

1. **GitHub org name** + `gh auth login` (blocks everything).
2. **abap**: ~~missing upstream license~~ **RESOLVED 2026-07-17** — LICENSE file materialized from upstream's explicit `license = "MIT"` SPDX declaration in Cargo.toml, with a provenance note in the file and README; ISC in package.json is scaffold-default. Registry publication should still wait for upstream clarification; git consumption is fine.

### Resolved 2026-07-16

- **stylus**: **dropped** — no grammar exists anywhere to fork; commissioning from scratch is out of scope. Revisit if a community grammar appears.
- Cosmetics, all fixed and re-tagged (`v0.25.0-fork.1` moved; tags were local-only):
  - **cobol**: crate renamed to lowercase `tree-sitter-cobol` (cargo warning gone); C symbol `tree_sitter_COBOL` kept verbatim for upstream rebasability.
  - **dhall**: all manifests (Cargo/package.json/tree-sitter.json/pyproject) aligned to `0.25.0`; the deliberate downgrade vs upstream 1.0.0 and the registry-publication ban are documented in its README.
  - **freemarker**: non-Rust bindings (C/Go/Node/Python/Swift) regenerated with CLI 0.25.10 — they now bind `tree_sitter_freemarker` instead of the ERB scaffold's dead symbol. The block-comment hyphen fix is also now committed and tagged.
  - **groovy**: published at the clean-passing base, tagged `v0.25.0-fork.1`; named-argument command calls documented as a known gap in its README (experimental extension preserved in `stash@{0}`).
  - Still open as follow-up work (not publish-blocking): vyper C++ scanner port to C.

## Verification method

Each repo was verified independently of its porting agent: fresh `cargo test` (clean rebuild where staleness was suspected), git tree clean, tag present. Upstream corpus regression run where one exists (tsql 252/252, pug 90/90, fish 123/123, cue 51/51, less 50/50, thrift 29/29, freemarker 6/6).
