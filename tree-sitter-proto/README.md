# tree-sitter-protobuf (fork)

> **Provenance (fork):** forked from <https://github.com/Clement-Jean/tree-sitter-proto>
> (commit `5c09ab434ea6a1dd03635ce58844b69a8d6bd90f`, 2024-03-27).
> **Changes vs upstream:** chosen over three rival grammars for the largest corpus (144
> cases vs 54); protobuf is a frozen spec so upstream dormancy is acceptable. Full
> modernization: ABI 14 -> 15 regen, tree-sitter.json added, legacy binding rewritten to
> LanguageFn. Covers proto2 and proto3. NOTE: crate name is `tree-sitter-protobuf`, C
> symbol tree_sitter_proto; added a synthetic smoke-test corpus (test/corpus_smoke/, 10
> files) and tests/smoke.rs. Upstream corpus: 72/72; smoke corpus: 0.00% error nodes
> under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-proto

tree-sitter grammar for Protobuf


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
