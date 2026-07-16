# tree-sitter-freemarker

> **Provenance (fork):** forked from <https://github.com/debba/tree-sitter-freemarker>
> (commit `36bb2937c43abea5f8fb1ddc89cf2730da5fec0e`, 2026-01-13).
> **Changes vs upstream:** finished the Rust binding scaffolding that upstream left on the
> embedded-template template: crate renamed `tree-sitter-embedded-template` →
> `tree-sitter-freemarker`; `bindings/rust/lib.rs` now binds `tree_sitter_freemarker` via the
> `tree-sitter-language` `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a
> dev-dependency; `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15);
> `tree-sitter.json` rewritten for the `freemarker` grammar (`ftl` file type); removed the
> stale ERB/EJS/etlua injection queries (they referenced node types that do not exist in this
> grammar); replaced the leftover embedded-template `test/corpus/main.txt` with FreeMarker
> cases; added a synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`;
> non-Rust bindings (C/Go/Node/Python/Swift) regenerated with tree-sitter-cli 0.25.10 —
> upstream shipped them as unrenamed embedded-template scaffolding binding the wrong C
> symbol (only the Rust binding is exercised by this program's tests; the others are
> generated-standard and untested).
> **Bug fix (grammar):** the `comment_content` rule (`/[^-]+|-/`) matched only one run of
> non-hyphens or a single lone hyphen, so any hyphen inside a `<#-- ... -->` comment (e.g.
> the `LICENSE-2.0` in an Apache header) broke the comment and cascaded errors over the
> whole file — real templates were ~50% error. Replaced with `/([^-]|-[^-]|--+[^>\]-])+/`,
> which consumes the full body including interior hyphens and stops only at `-->`/`--]`.
> Real apache/ofbiz templates dropped from ~50% to ~3.5% error; regression test added.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

[Apache FreeMarker](https://freemarker.apache.org/) template grammar for
[tree-sitter](https://github.com/tree-sitter/tree-sitter).

The grammar (by the upstream author, adapted from
[tree-sitter-embedded-template](https://github.com/tree-sitter/tree-sitter-embedded-template))
parses templates at the directive/interpolation level: `${...}` interpolations, `<#...>` /
`[#...]` directives, `<@...>` / `[@...]` user directives, and `<#-- ... -->` comments.
Expressions and directive parameters are captured as opaque `expression` /
`directive_content` tokens, not parsed into sub-trees.

## Usage (Rust)

```toml
[dependencies]
tree-sitter = "0.25"
tree-sitter-freemarker = { git = "…", tag = "v0.25.0-fork.1" }
```

```rust
let mut parser = tree_sitter::Parser::new();
parser
    .set_language(&tree_sitter_freemarker::LANGUAGE.into())
    .expect("Error loading FreeMarker parser");
let tree = parser.parse("<#if user??>${user.name}</#if>", None).unwrap();
assert!(!tree.root_node().has_error());
```

## Tests

`cargo test` runs the binding load test plus a smoke suite that parses the 12 synthetic
FreeMarker files under `test/corpus_smoke/` and asserts an error-node ratio below 5% per
file (measured: 0% on all files) and the presence of the expected node kinds
(`content`, `interpolation`, `expression`, `comment`, `directive`, `angle_directive`,
`square_directive`, `angle_user_directive`, `square_user_directive`, `directive_name`,
`directive_content`). `tree-sitter test` covers `test/corpus/main.txt` (6 cases, all
passing).

## Known limitations (inherited from upstream's grammar)

- `directive_content` cannot contain `/`, `>`, or `]`, so directive parameters with paths
  (`<#include "a/b.ftl">`) or comparison operators written as `>` mis-parse. Use `gt`/`gte`
  and flat include paths.
- ~~`comment_content` cannot span a `-` character~~ **— fixed in this fork** (see the
  provenance header): comments may now contain interior hyphens (e.g. `LICENSE-2.0`).
- Interpolation `expression` stops at the first `}`, so hash literals inside `${...}` are
  not supported.

## License

MIT, unchanged from upstream — see [LICENSE](LICENSE).

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
