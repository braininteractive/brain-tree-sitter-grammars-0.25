# tree-sitter-graphql (fork)

> **Provenance (fork):** forked from <https://github.com/bkegley/tree-sitter-graphql>
> (commit `5e66e961eee421786bdda8495ed1db045e06b5fe`, 2021-05-10 — the de-facto GraphQL
> grammar used by nvim-treesitter; upstream is dormant but the GraphQL language spec is
> stable, and the full spec surface parses).
> **Changes vs upstream:** full 0.25-line modernization — upstream was 0.17-era.
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 13 -> 15); added
> `tree-sitter.json`; `bindings/rust/lib.rs` rewritten from the legacy shape to the
> `tree-sitter-language` `LanguageFn` API (`pub const LANGUAGE`); `Cargo.toml`:
> `tree-sitter = "0.17"` hard dependency replaced by `tree-sitter-language = "0.1"`
> (with `tree-sitter = "0.25"` dev-only), version `0.25.0`, edition 2021, repository URL
> corrected (upstream scaffold pointed at tree-sitter-javascript); upstream corpus moved
> `corpus/` -> `test/corpus/`; added a synthetic smoke-test corpus (`test/corpus_smoke/`,
> 12 files: queries, mutations, subscriptions, SDL types/interfaces/unions, enums/inputs,
> fragments + inline fragments, directive definitions, scalars/extend, default values,
> descriptions, federation-style kitchen sink) and `tests/smoke.rs`. No scanner. No
> grammar-rule changes. Package name `tree-sitter-graphql` kept verbatim.
> Upstream corpus: 3/3; smoke corpus: 0.00% error nodes.
> **Rebase policy:** binding/regen/tests diff; upstream dormant, so this fork is
> effectively self-sufficient for the stable GraphQL spec.
> **Upstream PR:** pending (modernization is upstream-PR material if upstream revives).

# GraphQL Treesitter Grammar

Just attempting to learn treesitter by building a grammar for GraphQL

Thanks for the huge help! [tree-sitter-graphql](https://github.com/dralletje/tree-sitter-graphql)



## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
