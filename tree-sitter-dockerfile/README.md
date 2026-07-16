tree-sitter-dockerfile
===========================

> **Provenance (fork):** forked from <https://github.com/camdencheek/tree-sitter-dockerfile>
> (commit `971acdd`, 2025-01-12).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

Dockerfile grammar for [tree-sitter][].

[tree-sitter]: https://github.com/tree-sitter/tree-sitter

An action shot of highlighting in neovim:
<img width="886" alt="Screen Shot 2021-06-29 at 08 35 19" src="https://user-images.githubusercontent.com/12631702/123816907-f1f4d780-d8b4-11eb-83d2-95fa3abacaf2.png">


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
