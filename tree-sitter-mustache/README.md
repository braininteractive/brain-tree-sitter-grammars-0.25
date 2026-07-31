# tree-sitter-mustache (fork)

> **Provenance (fork):** forked from <https://github.com/TheLeoP/tree-sitter-mustache>
> (commit `0f1f3cf`, 2025-12-18).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0, dev-dep pinned 0.25 (upstream dev-dep 0.24 could not load its own ABI-15
> parser — upstream-note material); added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-
> mustache` kept verbatim. Upstream corpus: 20/20; smoke corpus: 0.00% error nodes under
> the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-mustache

[![CI][ci]](https://github.com/TheLeoP/tree-sitter-mustache/actions/workflows/ci.yml)

A tree-sitter parser for `.mustache` files, defined by
the [Mustache Specification][specification].

## References

- File format as defined by the [Mustache Specification][specification]

[ci]: https://img.shields.io/github/actions/workflow/status/TheLeoP/tree-sitter-mustache/ci.yml?logo=github&label=CI
[specification]: https://github.com/mustache/spec


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
