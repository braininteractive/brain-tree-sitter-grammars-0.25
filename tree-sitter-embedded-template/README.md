# tree-sitter-embedded-template (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter/tree-sitter-embedded-template>
> (commit `3499d85`, 2025-08-31).
> **Changes vs upstream:** pin-style — official ERB/EJS grammar, already ABI 15 +
> LanguageFn; version aligned to 0.25.0, dev-dep pinned 0.25. Covers both .erb and .ejs
> (consumers inject ruby/javascript into code nodes); added a synthetic smoke-test
> corpus (test/corpus_smoke/, 10+ files) and tests/smoke.rs. Package name `tree-sitter-
> embedded-template` kept verbatim. Upstream corpus: 7/7; smoke corpus: 0.00% error
> nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-embedded-template

[![CI][ci]](https://github.com/tree-sitter/tree-sitter-embedded-template/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![crates][crates]](https://crates.io/crates/tree-sitter-embedded-template)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-embedded-template)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-embedded-template)

A [tree-sitter](https://github.com/tree-sitter/tree-sitter) parser for templating languages like [ERB](https://ruby-doc.org/stdlib-2.5.1/libdoc/erb/rdoc/ERB.html) and [EJS](http://ejs.co), in which scripting code can be embedded within text content using the delimiters `<%` and `%>`.

References

- [ERB Documentation](https://ruby-doc.org/stdlib-2.5.1/libdoc/erb/rdoc/ERB.html)
- [EJS Documentation](http://ejs.co/#docs)
- [ETLua Documentation](https://github.com/leafo/etlua)
- [ETA Documentation](https://eta.js.org/docs)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter/tree-sitter-embedded-template/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-embedded-template?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-embedded-template?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-embedded-template?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
