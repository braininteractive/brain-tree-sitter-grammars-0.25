# tree-sitter-cairo

> **Provenance (fork):** forked from <https://github.com/starkware-libs/tree-sitter-cairo>
> (commit `b04ffb8`, 2026-06-14). Targets Cairo 2.x (Starknet) syntax.
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `Cargo.toml` moved `tree-sitter` from a hard
> dependency to a dev-dependency and now depends on `tree-sitter-language = "0.1"`;
> version set to `0.25.0`; `repository` corrected to the starkware-libs URL; `parser.c`
> regenerated with tree-sitter-cli 0.25.10 (ABI 15); `src/node-types.json` committed;
> added a synthetic smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> No grammar-rule changes; no external scanner.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

Cairo grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).
This is heavily inspired (copy pasted) from the [rust](https://github.com/tree-sitter/tree-sitter-rust) grammar for tree-sitter.

# Feedback

While is tested with the [cairo compiler repo](https://github.com/starkware-libs/cairo), [openzeppelin cairo contracts](https://github.com/OpenZeppelin/cairo-contracts) and [alexandria](https://github.com/keep-starknet-strange/alexandria), some patterns can be missing from those files hence cairo files might be incorrectly/incompletely highlighted. If you run into such a situation please create a minimal example that we can reproduce and open an issue.

# License

This project is licensed under the **Apache 2.0**.

See [LICENSE](LICENSE) for more information.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
