# tree-sitter-powershell (fork)

> **Provenance (fork):** forked from <https://github.com/airbus-cert/tree-sitter-powershell>
> (commit `e7bd348`, 2026-07-10).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0, dev-dep pinned 0.25; fixed upstream doctest (its empty-input example fails
> against its own grammar, which errors on empty programs — upstream-PR material); added
> a synthetic smoke-test corpus (test/corpus_smoke/, 10+ files) and tests/smoke.rs.
> Package name `tree-sitter-powershell` kept verbatim. Upstream corpus: 147/147; smoke
> corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-powershell

Powershell grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter)

## References

* [Powershell 7.3](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-15?view=powershell-7.3)

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
