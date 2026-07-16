<!--
================================================================================
FORK PROVENANCE
================================================================================
Upstream:        https://github.com/tree-sitter-grammars/tree-sitter-objc
Forked commit:   181a81b8f23a2d593e7ab4259981f50122909fda (2025-01-31)
Fork date:       2026-07-16
tree-sitter CLI: 0.25.10  ->  regenerated parser at ABI/LANGUAGE_VERSION 15
Upstream PR:     pending

WHY THIS FORK
-------------
Bare nullability-audit region markers (`NS_ASSUME_NONNULL_BEGIN` /
`NS_ASSUME_NONNULL_END`), which wrap nearly every modern Objective-C header,
were lexed as a `type_identifier` and started a bogus `declaration`. That
declaration then swallowed the following `@interface` / `@class` and cascaded
the whole translation unit into a top-level ERROR. Separately, availability /
deprecation attribute macros written with a project-defined (non-builtin) name,
e.g. `AF_API_AVAILABLE(ios(10))`, were unrecognized and cascaded the enclosing
declaration into an ERROR. (The builtin spellings such as `API_AVAILABLE`,
`NS_DEPRECATED_IOS` were already handled by `availability_attribute_specifier`.)

CHANGES (grammar.js only; minimal, surgical)
--------------------------------------------
1. New `nullability_region` node: the bare region markers
   (`NS_ASSUME_NONNULL_BEGIN/_END`, `NS_HEADER_AUDIT_BEGIN/_END`,
   `NS_REFINED_FOR_SWIFT`) now parse as a benign standalone top-level/block
   item instead of the type of a declaration. Given a low positive
   `prec.dynamic`, so GLR always prefers it over the error-recovery
   declaration parse regardless of what follows.
2. New `attribute_macro` node: an availability-style `IDENT(...)` attribute
   with a user-defined name, accepted in the *trailing* modifier position of
   `declaration`, `struct_declaration` (which backs `@property`) and
   `method_declaration` via a new `_trailing_declaration_modifiers` choice.
   Placed only in trailing position to avoid the pervasive `IDENT(`
   ambiguity with type specifiers/declarators at the start of a declaration;
   no new grammar conflicts were required.

Regenerated `src/parser.c`, `src/grammar.json`, `src/node-types.json`.
Upstream `test/corpus` (75 tests) still passes at 100% (no regressions).
Rust binding was already the modern `LanguageFn` shape; dev-dep bumped to
tree-sitter 0.25 and a `test/corpus_smoke/` + `tests/smoke.rs` smoke suite
added. No commit/tag is made here; publishing happens separately.

KNOWN GAPS (pre-existing, out of scope for this fix)
----------------------------------------------------
`typedef NS_ENUM(Type, Name) { ... }` macro-based enums and preprocessor
conditionals around declarations (`#if`/`#ifdef ... #endif`, `__has_warning`
in `#if` conditions) are still not modeled and remain a separate error class.

REBASE POLICY: re-apply the two grammar.js additions above onto upstream, then
`tree-sitter generate`. As-is, no support (see "Maintenance & support" below).
================================================================================
-->

# tree-sitter-objc


[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-objc/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-objc)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-objc)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-objc)


[Objective C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Introduction/introObjectiveC.html)
grammar for [tree-sitter](https://tree-sitter.github.io)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-objc/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-objc?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-objc?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-objc?logo=pypi&logoColor=ffd242

## Maintenance & support

This is a fork maintained for our own use, provided as-is, with no support and
no SLA. We are not responsible for maintenance. PRs welcome.
