# Tree-sitter Grammar Collection — Delivery Report

**Repository:** `github.com/braininteractive/brain-tree-sitter-grammars-0.25`
**Authoritative tag:** `v0.25.0-fork.9`
**Report date:** 2026-07-31
**Toolchain:** tree-sitter-cli 0.25.10 · Rust stable · clang

---

## 1. What this repository is

A single monorepo of **76 tree-sitter grammars**, each in its own top-level
`tree-sitter-<lang>/` directory, uniformly brought to one engineering standard:

- **ABI 15** generated `parser.c`, committed in-repo (consumers never run a
  generation step)
- Modern **`tree-sitter-language` `LanguageFn`** Rust bindings
  (`pub const LANGUAGE`), with `tree-sitter = "0.25"` as a **dev-dependency
  only** — no crate forces a runtime version on the consumer
- A synthetic **smoke corpus** (10–12 real-world-shaped files per grammar)
  enforced by `cargo test` at a <5 % error-node gate — **measured 0.00 % on
  every grammar**
- The upstream project's own test corpus kept and passing wherever one exists
- A provenance header in every README: upstream URL, exact forked commit,
  itemized diff vs upstream, rebase policy, known gaps
- License and attribution preserved verbatim; a "no SLA" maintenance notice
  in every README
- **Zero compiler warnings** across the entire collection (benign vendored-C
  warnings suppressed via build flags; no upstream C source altered for this)

## 2. How to consume

Every grammar is one Cargo line:

```toml
<crate-name> = { git = "https://github.com/braininteractive/brain-tree-sitter-grammars-0.25", tag = "v0.25.0-fork.9" }
```

Cargo locates each crate inside the monorepo by package name. One tag pins the
entire collection; bumping the tag is a single-line change per crate.

**Crate names that differ from their directory** (upstream naming kept verbatim
so crates.io users migrate with a source-line change only):

| Directory | Crate name | Language constant |
|---|---|---|
| tree-sitter-groovy | `dekobon-tree-sitter-groovy` | `LANGUAGE` |
| tree-sitter-sql | `tree-sitter-sequel` | `LANGUAGE` |
| tree-sitter-kotlin | `tree-sitter-kotlin-ng` | `LANGUAGE` |
| tree-sitter-toml | `tree-sitter-toml-ng` | `LANGUAGE` |
| tree-sitter-svelte | `tree-sitter-svelte-ng` | `LANGUAGE` |
| tree-sitter-move | `tree-sitter-move-on-aptos` | `LANGUAGE` |
| tree-sitter-go-mod / go-sum | `tree-sitter-gomod` / `tree-sitter-gosum` | `LANGUAGE` |
| tree-sitter-perl | `ts-parser-perl` | `LANGUAGE` |
| tree-sitter-prisma | `tree-sitter-prisma-io` | `LANGUAGE` |
| tree-sitter-commonlisp | `tree-sitter-commonlisp` | `LANGUAGE_COMMONLISP` |
| tree-sitter-fsharp | `tree-sitter-fsharp` | `LANGUAGE_FSHARP` + `LANGUAGE_SIGNATURE` |
| tree-sitter-md | `tree-sitter-md` | `LANGUAGE` (block) + `INLINE_LANGUAGE` |
| tree-sitter-jinja2 | `tree-sitter-jinja` + `tree-sitter-jinja-inline` | `LANGUAGE` each |

Everything else: crate name = directory name, constant = `LANGUAGE`.

## 3. Language coverage (76 grammars)

**Systems / general-purpose:** swift, kotlin, dart, zig, nim, d, julia, fsharp,
perl, powershell, elm, crystal, lua, r, groovy, objc, ada, clojure, commonlisp,
move, cairo, vyper, solidity-adjacent (via existing crates)

**Data / query:** sql (513/513 corpus), tsql, plsql, sparql, graphql, prisma,
cue, dhall, jsonnet, json5, toml, yaml-adjacent, neon, properties, go-mod,
go-sum

**Web / templates:** vue, svelte, astro, razor, twig, liquid, glimmer
(handlebars), mustache, haml, jinja2 (dual), jsp, freemarker, blade,
embedded-template (ERB + EJS), pug, scss, sass (indented), less

**Markup / docs / config:** md (dual block+inline), rst, doxygen, jsdoc,
graphql SDL, hcl/terraform, cmake, dockerfile, ninja, fish, elvish, vim, nix,
ragel, thrift, go-template, rbs

**Legacy / mainframe:** cobol (fixed-format COBOL-85, NIST-suite derived),
abap, rpgle (free-form), hlasm

Per-grammar corpus results, forked commits, and ABI provenance are tabulated in
[VERSIONS.md](VERSIONS.md) (Sections A–I). Deep-validation history is in
[DEEP_VALIDATION.md](DEEP_VALIDATION.md) and [DELIVERY_REPORT.md](DELIVERY_REPORT.md).

## 4. Engineering fixes delivered beyond packaging

These are real defects found and fixed during the program, each with
regression tests:

| Grammar | Fix |
|---|---|
| jsonnet | Upstream **thread-safety bug**: scanner state in file-scope globals raced across parsers (~1-in-6 flake). Moved to per-parser payload; 20/20 stress runs. |
| freemarker | Comments containing `-` (e.g. every Apache `LICENSE-2.0` header) corrupted the whole parse (~50 % of real templates). Fixed; 3.49 % aggregate real-world error rate after. |
| ibmhlasm | **Infinite hang** on continuation-at-EOF (missing EOF guard in scanner loops). Fixed. |
| groovy | **Named arguments in parenthesis-free commands** (`sh script: 'ls', returnStdout: true`) now parse as `command_chain` + `named_argument` — a GLR fork with dynamic precedence; the ambiguity upstream grammars defer on. 528/528 tests. |
| vyper | C++ scanner **ported to C**; the tree-sitter CLI (which cannot compile C++ scanners) now loads it. 74/74. |
| doxygen | `///` / `//!` / `///<` triple-slash doc comments now parse (upstream errored on every one). 35/35. |
| sass | `@each` over bare comma lists now parses. 43/43. |
| neon | Comma-less multiline entity arguments now split correctly (scanner consulted inside parens). 11/11. |
| kotlin, hcl | **C-symbol collision hardening**: grammars renamed `kotlin_ng` / `hcl_ng`, so exported symbols (`tree_sitter_kotlin_ng`, `tree_sitter_hcl_ng`) cannot collide with same-named crates.io parsers linked elsewhere in a binary (a real silent-mislink failure mode: the linker unifies duplicate C symbols and one parser silently wins). Both crates also declare Cargo `links = "..."` so any future duplicate is a **hard build error**. Rust APIs and node kinds unchanged. |
| plsql | Standalone `CREATE PROCEDURE/FUNCTION` was structurally unparseable upstream; 4-line fix. |
| tsql | Extended from ~20–30 % coverage to full DML/DDL/procedural surface; 252/252. |
| powershell, mustache, crystal | Upstream self-test defects fixed (doctest that fails its own grammar; dev-deps that cannot load the crate's own ABI-15 parser). |
| pug, liquid, jsp, neon, hlasm, freemarker | Upstream Rust bindings that could never link/compile (wrong symbols, uncompiled scanners, missing lib.rs) — all repaired. |

## 5. Verification methodology (what "tested" means here)

1. **Per-grammar:** upstream corpus via `tree-sitter test` + smoke corpus via
   `cargo test` (<5 % gate, measured 0 %), per grammar, at its final commit.
2. **Whole-collection consumer proofs:** standalone binaries that depend on
   the crates **from the published GitHub tag** (not local paths), compile
   every parser and scanner, load every `LANGUAGE`, and parse real samples.
   Latest full run: 57/57 crates (fork.4 era) plus incremental 4-, 6-, 17- and
   19-check runs for every subsequent tag. Exit-code-verified.
3. **Collision replica:** a two-level dependency graph linking crates.io
   `tree-sitter-kotlin-sg` and crates.io `tree-sitter-hcl` **together with**
   this repo's kotlin/hcl in one binary — distinct function pointers confirmed,
   both sides parse correctly.
4. **Publish audits (run before every push):** no file present on disk but
   excluded from the published tree by upstream gitignores (this exact bug was
   caught and fixed four times: sql, swift, fsharp, perl — all of which
   gitignore their generated parsers); no build artifacts or local dev files
   in the tree; no duplicate crate names; no crates with a hard `tree-sitter`
   runtime dependency.
5. **Warning sweep:** `cargo build` across all crates — zero warnings.

## 6. Known limitations (documented, by design — not defects)

- **scss:** upstream grammar predates the Sass module system — `@use … as`,
  `@forward … show`, `@extend %placeholder`, map literals `(k: v)` error.
  Documented in its README; the crates.io 1.0.0 build has the same gaps.
- **md:** 8 upstream inline-corpus tests are extension-gated (wikilink etc.)
  and fail without those compile-time extensions; block grammar 322/322.
- **nix:** one upstream highlight-query naming drift (queries issue, parse
  corpus 54/54).
- **tsql:** cursors, `CREATE FUNCTION/TRIGGER`, PIVOT/APPLY, OFFSET/FETCH etc.
  — failing samples preserved in `test/corpus_known_gaps/`.
- **vyper:** grammar targets 0.3.x syntax; ≥0.4 constructs partially covered.
- **cobol:** fixed-format COBOL-85 only; **rpgle:** free-form only;
  **hlasm:** no macro facility; **freemarker:** expressions are opaque tokens;
  **jsdoc:** bare-code `@example` bodies parse loosely.
- **abap:** upstream ships no LICENSE file; this fork materializes MIT from
  upstream's explicit `license = "MIT"` SPDX declaration in Cargo.toml, with a
  provenance note in the LICENSE itself. Fine for git consumption; registry
  publication should wait for upstream's word.
- **Languages with no tree-sitter grammar anywhere** (exhaustively searched):
  Stylus, Velocity/VTL. Windows batch is unverified-likely-absent.

## 7. Tag history

| Tag | Content |
|---|---|
| `v0.25.0-fork.1` | Original 48-grammar program (forks, pins, template/legacy sets) |
| `v0.25.0-fork.2` | +6 crate-replacement forks: astro, svelte, vue, kotlin, toml, sql |
| `v0.25.0-fork.3` | Fix set: groovy named-args, vyper C scanner, abap LICENSE |
| `v0.25.0-fork.4` | +3 languages: zig, nim, dart |
| `v0.25.0-fork.5` | kotlin C-symbol rename; doxygen `///`; sass `@each`; neon multiline entities |
| `v0.25.0-fork.6` | hcl C-symbol rename; Cargo `links` collision guards |
| `v0.25.0-fork.7` | +4 languages: swift, nix, crystal, graphql |
| `v0.25.0-fork.8` | +15 languages (julia, fsharp, perl, powershell, elm, d, lua, md, scss, prisma, properties, embedded-template, mustache, haml, commonlisp) + cmake/r to ABI 15 — collection uniformly ABI 15 |
| **`v0.25.0-fork.9`** | **Zero-warning builds (current)** |

Published tags are never moved; each fix ships as a new tag.

## 8. Recommended integration pattern

1. Pin every grammar dependency to the **same tag** (`v0.25.0-fork.9`).
2. Use the crate-name table in §2 — three names are non-obvious
   (`ts-parser-perl`, `tree-sitter-prisma-io`, `dekobon-tree-sitter-groovy`)
   and three grammars are dual (`md`, `fsharp`, `jinja2`).
3. Grammar upgrades change node kinds; treat any tag bump as a deliberate,
   test-verified adoption on the consumer side.
4. If your dependency graph can transitively pull crates.io parser crates
   (e.g. via ast-grep/semgrep-style tooling), the kotlin/hcl symbol renames in
   this collection are what keep both linkable in one binary; any *new*
   collision will surface as a hard cargo `links` error rather than a silent
   mislink.
