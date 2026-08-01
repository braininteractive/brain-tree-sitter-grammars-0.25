# tree-sitter-nginx (fork)

> **Provenance (fork):** forked from <https://github.com/opa-oz/tree-sitter-nginx>
> (commit `47ade644d754cce57974aac44d2c9450e823d4f4`, 2026-01-02).
> **Changes vs upstream:** chosen over the GitLab rival for the larger corpus + scanner;
> pin-style — already ABI 15 + LanguageFn; version aligned to 0.25.0; added a synthetic
> smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus:
> 30/30; smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# tree-sitter-nginx

![example](./docs/example.png)


## Features
- [x] Comments
- [x] Directives
- [x] Location
    - [ ] Regex injection
- [x] If
- [x] Map
- [x] Types
    - [x] `boolean`
    - [x] `number`
    - [x] `string`
    - [x] `auto`
    - [x] `size` (`100k`)
    - [x] `time` (`500ms`)
    - [x] `cpumask`
    - [x] `mask`
    - [x] `file`
    - [x] `log_level`
    - [x] `connection_method`



## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
