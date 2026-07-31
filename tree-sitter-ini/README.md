# tree-sitter-ini (fork)

> **Provenance (fork):** forked from <https://github.com/justinmk/tree-sitter-ini>
> (commit `e4018b5176132b4f3c5d6e61cea383f42288d0f5`, 2025-12-08).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0. Note: bare keys without `=`/`:` are not INI (dialect-ambiguous) and error by
> design; added a synthetic smoke-test corpus (test/corpus_smoke/, 10 files) and
> tests/smoke.rs. Upstream corpus: 11/11; smoke corpus: 0.00% error nodes under the
> cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

tree-sitter-ini
==================

This grammar implements the [INI format](https://en.wikipedia.org/wiki/INI_file).

Overview
--------

Example INI file:

```ini
[section 1]
some_key = some_value
another-key = another value

[another section]
# Keys may contain whitespace.
key 1 = value 1
# Value may be empty.
key_2 =
```

See [test/corpus/](./test/corpus/) for more examples.

Notes
-----

- Section name must appear on a line by itself.
- Equals sign (=) and semicolon (;) are [reserved characters](https://en.wikipedia.org/wiki/INI_file#Key-value_pairs)
  and cannot appear in the key. Any whitespace surrounding the key is stripped.
- Comments (`;` or `#`) must start at column 1. Trailing comments are not supported yet. [#13](https://github.com/justinmk/tree-sitter-ini/issues/13)
- Duplicate names are not checked.
- Line continuations (`\`) are not supported.
- `setting_value` includes whitespace. [#3](https://github.com/justinmk/tree-sitter-ini/issues/3).
  Should values exclude surrounding whitespace?
- [Quoted keys/values](https://en.wikipedia.org/wiki/INI_file#Quoted_values) are not supported yet.
- Escape sequences are not supported.

Reference
---------

- https://en.wikipedia.org/wiki/INI_file
- https://github.com/textmate/ini.tmbundle

Release
-------

Steps to perform a release: https://tree-sitter.github.io/tree-sitter/creating-parsers/6-publishing.html

1. Update tree-sitter CLI.
   ```
   npm install tree-sitter-cli
   ```
2. Bump the version.
   ```
   tree-sitter version x.y.z
   ```
3. Regenerate and test.
   ```
   rm Cargo.toml
   tree-sitter init
   cargo test
   tree-sitter generate && tree-sitter test
   ```
4. Commit the generated files
   ```
   git add .
   git commit -m 'release'
   ```
5. Push
   ```
   git push
   ```
6. Tag and release: https://github.com/justinmk/tree-sitter-ini/releases/new
7. Run
   ```
   cargo publish
   ```



## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
