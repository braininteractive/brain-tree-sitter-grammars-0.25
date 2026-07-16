# `tree-sitter-glimmer`

> A TreeSitter grammar for Glimmer (`.hbs`) templates

---

## Fork provenance

This is a fork of [`ember-tooling/tree-sitter-glimmer`](https://github.com/ember-tooling/tree-sitter-glimmer).

- **Upstream:** https://github.com/ember-tooling/tree-sitter-glimmer
- **Forked at commit:** `c67a73679db2945a686ca45d3e5318d86138e72a` (2026-07-03)
- **Regenerated with:** tree-sitter CLI 0.25.10 (ABI / `LANGUAGE_VERSION` 15)
- **Upstream PR:** pending

### What changed in this fork

1. **Grammar fix — bare HTML void elements** (`grammar.js`).
   Upstream only accepted the *self-closing* form of void elements
   (`<br />`, `<img />`). Real Ember/Glimmer templates overwhelmingly use the
   idiomatic HTML spelling **without** a closing slash — `<br>`,
   `<input type="text">`, `<img src="x">`, `<hr>`, `<meta charset="utf-8">`,
   etc. — and upstream produced `ERROR` nodes for all of these.

   The `element_node_void` rule now accepts a bare `>` terminator (in addition
   to `/>`) **only** for the 14 standard HTML void element names — `area`,
   `base`, `br`, `col`, `embed`, `hr`, `img`, `input`, `link`, `meta`, `param`,
   `source`, `track`, `wbr` — modeled as a `_void_element_name` choice of plain
   string literals aliased to `tag_name`. Because they are string literals they
   win the equal-length lexer tie against the generic `tag_name` regexp, while
   any longer name (e.g. `input-group`, `br-thing`, `img.foo`) still lexes as a
   normal `tag_name` and keeps its paired open/close semantics. Non-void
   elements are unaffected: `<div>` still requires `</div>`. The self-closing
   form (`<img />`) still parses to the identical `(element_node_void (tag_name))`
   tree, so no existing corpus test changed.

   Measured impact on the [emberobserver/client](https://github.com/emberobserver/client)
   app (99 `.hbs` files): files containing parse errors dropped from **18 → 1**
   (the one remaining error is an unrelated pre-existing issue: a bare literal
   `>` in text content).

2. **Packaging / binding modernization only** (no other grammar changes):
   - `Cargo.toml`: version `0.25.0`, `edition = "2021"`, dependency
     `tree-sitter-language = "0.1"` (removed the old `tree-sitter` runtime
     dependency), `cc` build-dependency, `tree-sitter = "0.25"` dev-dependency.
   - `bindings/rust/lib.rs`: modern `LANGUAGE: LanguageFn` constant (replacing
     the legacy `pub fn language() -> Language`), plus exported query
     constants.
   - Added `test/corpus_smoke/` (12 real-shaped `.hbs` files incl. void
     elements, block helpers, components, mustache) and `tests/smoke.rs`.
   - Preserved `queries/glimmer/*`, the external `scanner.c`, and the upstream
     `LICENSE.md` / attribution verbatim.

### Rebase policy

Fork kept intentionally minimal (one surgical grammar rule + packaging) to ease
rebasing on upstream. The intent is to land the void-element fix upstream and
drop the fork.

### Maintenance & support

Provided **as-is**, with **no support** and **no SLA**. The fork author is
**not responsible for maintenance**. PRs welcome.

---

[![Verify](https://github.com/ember-tooling/tree-sitter-glimmer/actions/workflows/verify.yml/badge.svg)](https://github.com/ember-tooling/tree-sitter-glimmer/actions/workflows/verify.yml)

## Sample Highlighting

Up-to-date sample highlighting can be found on the web page for this project [here](https://ember-tooling.github.io/tree-sitter-glimmer/).

## Usage

### NeoVim

This package is already available as part of `nvim-treesitter` as the `glimmer` parser.

You can also follow [these instructions](https://github.com/ember-tooling/tree-sitter-glimmer/wiki/Highlighting-in-NeoVim) to allow `nvim-treesitter` to use a locally-cloned version of this parser, which can be useful for development or trying out the most up-to-date highlighting.
