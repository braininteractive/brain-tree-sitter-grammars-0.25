# VERSIONS.md — Grammar Manifest

**Publication model (2026-07-16):** the whole collection ships as a **single monorepo** — one grammar per top-level `tree-sitter-<lang>/` directory. Rust consumption: `<crate-name> = { git = "<monorepo-url>", tag = "v0.25.0-fork.2" }` — cargo locates the crate inside the repo by package name (crate names can differ from directory names; see the tables). The per-grammar tags listed below predate the monorepo merge; the authoritative tag is the monorepo-wide one — **latest: `v0.25.0-fork.2`** (adds the Section F crate-replacement forks; `v0.25.0-fork.1` = the original 48-grammar set). (Per-repo fork histories are archived locally, not published.)

## Section F — crate-replacement forks (added 2026-07-17, tag `v0.25.0-fork.2`)

Drop-in replacements for weak/stale community crates. Package names kept verbatim from upstream so a consumer only changes the dependency *source*, never the import.

| Grammar (dir) | Crate name | Upstream rev forked | ABI | Corpus | Replaces crates.io dep |
| --- | --- | --- | --- | --- | --- |
| tree-sitter-astro | `tree-sitter-astro` | virchau13/tree-sitter-astro @ `213f6e6` (2025-04-24) | 14→15 + full binding modernization (was 0.20-era) | 22/22 upstream, 12-file smoke 0% | `tree-sitter-astro-next 0.1.1` |
| tree-sitter-svelte | `tree-sitter-svelte-ng` | tree-sitter-grammars/tree-sitter-svelte @ `ae5199d` (2024-10-19) | 14→15 | 45/45 upstream, 12-file smoke 0% | `tree-sitter-svelte-next 0.1.1` |
| tree-sitter-vue | `tree-sitter-vue` | tree-sitter-grammars/tree-sitter-vue @ `ce8011a` (2026-01-24) | 15 (fixed broken 0.20 Cargo dep — crate could not build on 0.25) | 10/10 upstream, 12-file smoke 0% | `tree-sitter-vue-updated 0.1` |
| tree-sitter-kotlin | `tree-sitter-kotlin-ng` | tree-sitter-grammars/tree-sitter-kotlin @ `3dea6df` (2025-01-16) | 15 (pin-style) | 22/22 upstream, 12-file smoke 0% | `tree-sitter-kotlin-ng 1.1` (pin) |
| tree-sitter-toml | `tree-sitter-toml-ng` | tree-sitter-grammars/tree-sitter-toml @ `64b5683` (2024-12-03) | 14→15 | 18/18 upstream, 12-file smoke 0% | `tree-sitter-toml-ng 0.7` (pin) |
| tree-sitter-sql | `tree-sitter-sequel` | DerekStride/tree-sitter-sql @ `c2e1e08` (2026-03-02) | 15 (pin-style) | 513/513 upstream, 12-file smoke 0% | `tree-sitter-sequel 0.3` (pin) |

Notes: `cmake`, `hcl`, `r` (raw-git-dep families) were already in the monorepo (Section A). The official `tree-sitter-go` crate needs no fork — a consumer resolving both 0.23 and 0.25 simultaneously is a consumer-side pin conflict, not a grammar problem.

All grammars target the tree-sitter **0.25** runtime.
"0.26-ready?" = regenerated at ABI 15 with `tree-sitter.json` present (loads on newer runtimes); definitive confirmation pending a CLI-0.26 regen pass.
Upstream PR links to be filled when PRs are opened (blocked on GitHub auth).

## Section B — delivered forks

| Grammar | Tag | ABI | Upstream rev forked | Upstream PR | 0.26-ready? |
| --- | --- | --- | --- | --- | --- |
| json5 | v0.25.0-fork.1 | 15 | Joakker/tree-sitter-json5 @ `248b856` | pending | yes |
| dockerfile | v0.25.0-fork.1 | 15 | camdencheek/tree-sitter-dockerfile @ `971acdd` | pending | yes |
| blade | v0.25.0-fork.1 | 15 | EmranMR/tree-sitter-blade @ `5dbdcb0` | pending | yes |
| ninja | v0.25.0-fork.1 | 15 | alemuller/tree-sitter-ninja @ `0a95cfd` | pending | yes |
| jsonnet | v0.25.0-fork.1 | 15 | sourcegraph/tree-sitter-jsonnet @ `ddd075f` | pending (incl. scanner thread-safety fix) | yes |
| dhall | v0.25.0-fork.1 | 15 | jbellerb/tree-sitter-dhall @ `6201325` | pending | yes |
| plsql | v0.25.0-fork.1 | 15 | AndreasMaierDe/tree-sitter-plsql @ `28aebef` | pending (incl. CREATE PROC/FUNC fix) | yes |
| tsql | v0.25.0-fork.1 | 15 | Crary-Systems/tree-sitter-tsql @ `443d2bc` | pending (substantial extension) | yes |
| fish | v0.25.0-fork.1 | 15 | ram02z/tree-sitter-fish @ `f435b0b` | pending | yes |
| less | v0.25.0-fork.1 | 15 | jimliang/tree-sitter-less @ `e5ae624` | pending | yes |
| thrift | v0.25.0-fork.1 | 15 | duskmoon314/tree-sitter-thrift @ `68fd0d8` | pending | yes |
| cue | v0.25.0-fork.1 | 15 | eonpatapon/tree-sitter-cue @ `dd7b90e` | pending | yes |
| pug | v0.25.0-fork.1 | 15 | zealot128/tree-sitter-pug @ `13e9195` | pending (incl. build fixes) | yes |
| stylus | — | — | none found (no tree-sitter stylus grammar exists) — **DROPPED 2026-07-16** (commissioning out of scope; revisit if a community grammar appears) | — | — |
| freemarker | v0.25.0-fork.1 | 15 | debba/tree-sitter-freemarker @ `36bb293` | pending (bindings finished) | yes |
| sparql | v0.25.0-fork.1 | 15 | GordianDziwis/tree-sitter-sparql @ `1ef52d3` | pending | yes |
| vyper | v0.25.0-fork.1 | 15 | madlabman/tree-sitter-vyper @ `e4d43a8` | pending (scanner build fix) | yes (Rust crate; CLI cannot load C++ scanner) |
| cobol | v0.25.0-fork.1 | 15 | yutaro-sakamoto/tree-sitter-cobol @ `e99dbdc` | pending | yes |
| abap | v0.25.0-fork.1 | 15 | mkoval1/tree-sitter-abap @ `c7604df` | pending — ⚠️ upstream has no LICENSE, hold publish | yes |
| abap (D-extension) | (same tag, moved to `6a15e47`) | 15 | + FORM/ENDFORM, PERFORM (incl. `name(prog)`/IN PROGRAM/IF FOUND), ELSE/ELSEIF, CASE/WHEN, ordering comparisons; 105/105 corpus | pending | yes |
| rpgle | v0.25.0-fork.1 | 15 | extracted from mayflower/rpg-explainer @ `a1a8960` (path `tree-sitter-rpg/`, grammar from `718f7d5`) | pending | yes |
| hlasm (ibmhlasm) | v0.25.0-fork.1 | 15 | janus-llm/tree-sitter-ibmhlasm @ `5f7ef6f` | pending (incl. lib.rs fix) | yes |

## Section A — pinned forks

All three upstreams were already 0.25-clean (modern `LanguageFn` bindings) — forks exist purely for pinning; diffs are smoke-tests/README only (plus a test-only dev-dep bump for r).

| Grammar | Tag | ABI | Upstream rev pinned | Upstream PR | 0.26-ready? |
| --- | --- | --- | --- | --- | --- |
| hcl | v0.25.0-fork.1 | 15 | MichaHoffmann/tree-sitter-hcl @ `64ad627` (2026-01-17) | n/a (no code change) | yes |
| cmake | v0.25.0-fork.1 | 14 | uyha/tree-sitter-cmake @ `ca627bb` (2026-07-08) | n/a (no code change) | no — pin-only diff kept upstream ABI 14; one `tree-sitter generate` away |
| r | v0.25.0-fork.1 | 14 | r-lib/tree-sitter-r @ `58a2279` (2026-06-22) | n/a (dev-dep bump only) | no — pin-only diff kept upstream ABI 14; one `tree-sitter generate` away |

## Section C — template languages

| Language | Verdict | Repo / rev | Notes | 0.26-ready? |
| --- | --- | --- | --- | --- |
| jinja2 | **adopt-as-is** | cathaysia/tree-sitter-jinja @ `c213d37` (v0.13.0, 2026-07-02, crates.io) | Two grammars: `jinja` + `jinja_inline` (wire both, as nvim-treesitter does). ABI 15, active, big corpus, injections.scm. Legacy `language()` binding but loads on 0.25 — no fork per rule E. | yes |
| razor | **adopt-as-is** | tris203/tree-sitter-razor @ `900f53d` (2026-06-11, crates.io 0.1.0) | Already exactly the target LanguageFn shape; ABI 15; injections for C#/HTML islands. | yes (dev-tested on 0.26.8 upstream) |
| twig | **forked** — tag `v0.25.0-fork.1` @ `b626250` | gbprod/tree-sitter-twig @ `0afd9a6` (Helix/nvim pin) | ABI 14→15, LanguageFn binding, 12-file corpus 0% errors, 48/48 upstream corpus. injections.scm preserved (upstream queries name 3 not-yet-existing node types — warns, documented). License WTFPL. | yes |
| angular | **adopt-as-is** | dlvandenberg/tree-sitter-angular @ `38a8014` (2026-05-15, crates.io 0.9.2) | ABI 15, active, extends tree-sitter-html (needs html grammars wired). Crate pins `tree-sitter ~0.25`. | partial — grammar loads on 0.26; published crate pins ~0.25 |

| liquid | **forked** — tag `v0.25.0-fork.1` @ `1d01415` | hankthetank27/tree-sitter-liquid @ `e45dbac` (nvim pick; Shopify's own repo is archived) | Upstream Rust crate was doubly broken (0.20 hard dep + build.rs never compiled scanner.c). ABI 15, LanguageFn, scanner compiled, 92/92 upstream corpus, 12-file smoke 0%. Gaps: space-separated for-modifiers, `render ... with` dotted access, Shopify-style include args. | yes |
| handlebars | **adopt-as-is** | ember-tooling/tree-sitter-glimmer @ `c67a736` (2026-07-03) | De-facto handlebars grammar (nvim+Helix). ABI 15; legacy `language()` binding but verified on 0.25 and builds on 0.26.3. | yes |
| mustache | **adopt-as-is** | TheLeoP/tree-sitter-mustache @ `0f1f3cf` (2025-12-18) | ABI 15, LanguageFn. Own CI test can't load (dev-dep 0.24 vs ABI-15 parser) — consumers unaffected; upstream-note material. Use for `.mustache`; glimmer covers `.hbs`. | yes |
| jsp | **forked** — tag `v0.25.0-fork.1` @ `9d9c8f4` | karlvr/tree-sitter-jsp @ `5cec1a3` (2026-04-01) | Net-new Rust bindings (upstream had Swift/C only). Template-overlay design: HTML/Java via injections (preserved). ABI 15, 8/8 upstream corpus, 12-file smoke 0%. (merico-dev candidate rejected: dead since 2021.) | yes |
| jsf/facelets | **none-found** | — | No tree-sitter grammar exists. Practical path: XHTML via html/xml grammar + EL injection; the jsp fork already parses `#{}` deferred EL. | — |
| haml | **adopt-as-is** | vitallium/tree-sitter-haml @ `3ea1526` (2026-02-03) | ABI 15, LanguageFn, active, injections present. | yes |

_Pending research: slim, nunjucks, mdx, marko; jinja2-proper fork (final brief C6) in flight._

## Section E — category sweep (critical tier)

| Language | Verdict | Repo / rev | Notes | 0.26-ready? |
| --- | --- | --- | --- | --- |
| objc | **adopt-as-is** | tree-sitter-grammars/tree-sitter-objc (amaanq) @ `181a81b` (2025-01-31, crates.io 3.0.2) | ABI 14, verified loads/parses on 0.25. ⚠️ **ObjC++ (.mm) NOT covered** — needs a separate decision. | no (ABI 14; likely loads, not regenerated per rule E) |
| matlab | **adopt-as-is** | acristoffers/tree-sitter-matlab @ `c9ef947` (2026-06-25, crates.io 1.3.0) | ABI 15, LanguageFn, active. | yes |
| go-template | **forked** — tag `v0.25.0-fork.1` @ `5624cef` | ngalaiko/tree-sitter-go-template @ `aa71f63` | Upstream Rust binding was broken (wrong C symbol `tree_sitter_go_template` vs exported `tree_sitter_gotmpl` — could never link); fixed + ABI 15 + LanguageFn. 90/90 upstream corpus; 12-file corpus 0%. Helm dialect shares the parser (no separate Rust binding upstream). | yes |
| gomod | **forked (pin)** — tag `v0.25.0-fork.1` @ `d5d5f8b` | camdencheek/tree-sitter-go-mod @ `2e88687` (2025-10-22) | Upstream HEAD already modern (ABI 15, LanguageFn) — pin-style fork per final brief C5; diff is tests/README + dev-dep. Gaps: no `godebug` directive; absolute `/` replace paths don't parse. | yes |
| gosum | **forked (pin)** — tag `v0.25.0-fork.1` @ `911d5ff` | amaanq/tree-sitter-go-sum @ `27816eb` (2025-07-10) | Regenerated ABI 14→15; binding was already LanguageFn. Gaps: `!`-escaped uppercase module paths, empty files. | yes |
| ipynb (Jupyter) | **out-of-scope by design** | — | Container format (JSON wrapping cells), needs a consumer-side extractor, not a grammar. Recorded so it doesn't look forgotten. | — |

### Injection grammars

| Language | Verdict | Repo / rev | Notes | 0.26-ready? |
| --- | --- | --- | --- | --- |
| jsdoc | **adopt-as-is** | tree-sitter/tree-sitter-jsdoc @ `658d18d` (official, v0.25.0) | ABI 15, modern LanguageFn. Injection target for JS/TS `/** */` comments. | yes |
| doxygen | **forked** — tag `v0.25.0-fork.1` @ `366b987` | tree-sitter-grammars/tree-sitter-doxygen @ `ccd998f` (2024-06-09) | Was 0.20-era legacy binding, ABI 14 → 15, LanguageFn, injections.scm preserved + exported. 33/33 upstream corpus, 12-file smoke 0%. Gap: `///` triple-slash comments unsupported upstream (ERROR node) — upstream-issue material. | yes |
| comment | **adopt-as-is** | stsewd/tree-sitter-comment @ `66272d2` (2025-12-16, v0.3.0) | ABI 15, LanguageFn. (Worklist's org attribution was wrong — still lives under stsewd, active.) Ships NO queries dir — consumers supply their own. | yes |
| regex | **adopt-as-is** | tree-sitter/tree-sitter-regex @ `b2ac15e` (official, 0.25.0) | ABI 15, LanguageFn. Lookarounds/backrefs/unicode-props verified clean. | yes |

_Pending sweep research: docs+tooling (rst/asciidoc/sass/just/nu/vim/elisp), apex/move/cairo/mojo, hardware+shaders (verilog/vhdl/glsl/hlsl/wgsl/gdscript)._

### Section D research (final brief) — occurring-in-repos, availability unconfirmed

| Language | Verdict | Repo / rev | Notes | 0.26-ready? |
| --- | --- | --- | --- | --- |
| ragel | **forked** — tag `v0.25.0-fork.1` @ `8d16bc9` | alemuller/tree-sitter-ragel | ABI→15, LanguageFn, node-types committed, 12-file corpus, tests green. | yes |
| elvish | **forked** — tag `v0.25.0-fork.1` @ `a7bf5ca` | elves/tree-sitter-elvish @ `5e7210d` (2023-07-17) | ABI 15, LanguageFn, 12-file corpus, tests green. | yes |
| velocity | **none-found** | — | No tree-sitter grammar for Apache Velocity/VTL exists (GitHub/nvim/Helix/Zed all empty; only the official JavaCC parser). Not built (rule 5). | — |
| rbs | **adopt-as-is** | joker1007/tree-sitter-rbs @ `5282e2f` (2025-11-14) | ABI 15, LanguageFn, tree-sitter.json, full grammar + queries; verified loads on 0.25. (Minor: keeps `tree-sitter` in `[dependencies]` not dev-only — builds fine; not worth a fork.) | yes |
| neon | **forked** — tag `v0.25.0-fork.1` @ `8d791cb` | shubhamdhaboya/tree-sitter-neon @ `20a06e9` (2026-05-29) | Real grammar (INDENT/DEDENT scanner) but no Rust crate (bindings gitignored). Added full bindings, ABI 15, 12-file corpus 0%, 10/10 upstream corpus. Gap: comma-less multiline entities need explicit `,`. | yes |

### Recovered stalled-agent repos (finished manually; UNCOMMITTED — user commits/tags)

| Language | Verdict | Repo / rev | Notes | 0.26-ready? |
| --- | --- | --- | --- | --- |
| sass (indented) | **forked** (C7) | bajrangCoder/tree-sitter-sass @ `fb280c4` (2026-01-18) | Indented `.sass` grammar **does exist** (parses indented 0-err, rejects braced) — resolves C7 without SCSS-adaptation. Built full Rust bindings from scratch (upstream had none), 12-file corpus 0 errors. Gap: `@each` comma lists don't parse. | yes |
| rst | **forked** | stsewd/tree-sitter-rst @ `a60f107` (2026-06-09) | ABI 15, LanguageFn, 12-file corpus 0 errors. | yes |
| vim | **forked** | tree-sitter-grammars/tree-sitter-vim @ `039c8d0` (2026-07-12) | ABI 15, LanguageFn, external scanner, 13-file corpus 0 errors. | yes |
| cairo | **forked** | starkware-libs/tree-sitter-cairo @ `b04ffb8` (2026-06-14) | Cairo 2.x/Starknet. Fixed Cargo (was `tree-sitter` hard dep, v0.0.1, wrong repo URL); 12-file corpus 0 errors incl. contracts/interfaces/generics. | yes |
| move | **forked** | (agent-tagged) | ABI 15, LanguageFn, 12-file corpus, tests green, tagged. | yes |
| groovy | **published** — tag `v0.25.0-fork.1` @ `8073fed` (2026-07-16) | dekobon standalone grammar (synthesises murtaza64 + amaanq) | Clean-passing base committed and tagged; corpus + stress tests green. Named-argument commands documented as known gap in README (experimental extension preserved in `stash@{0}`; proper fix = the ambiguity upstream itself deferred). | yes |

### Section D research (final brief) — occurring-in-repos, availability unconfirmed

| Grammar | Tag | ABI | Upstream rev forked | Upstream PR | 0.26-ready? |
| --- | --- | --- | --- | --- | --- |
| ada | v0.25.0-fork.1 @ `a21dbbc` | 15 | briot/tree-sitter-ada @ `6b58259` (2025-12-16) | pending (regen-only; binding was already modern) | yes |
| clojure | v0.25.0-fork.1 @ `f48ebc6` | 15 | sogaiu/tree-sitter-clojure @ `e43eff8` (2025-08-26) | n/a — upstream rejects bindings by policy; Rust binding is a permanent fork-side diff | yes |
| abap (FORM/PERFORM + CASE + ELSE ext.) | v0.25.0-fork.1 moved to `6a15e47` | 15 | see Section B row | pending | yes |

Completeness findings: ada — "partial-by-design" outdated, zero holes found (127/127 upstream corpus, Ada 2022 expressions parse); clojure — reader-level design respected, all reader syntax verified (115/115), no extensions; consumers interpret forms semantically.

_Pending: groovy, hlasm macros._
