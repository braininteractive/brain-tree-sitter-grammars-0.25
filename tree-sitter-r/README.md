# tree-sitter-r

> **Provenance (fork):** forked from <https://github.com/r-lib/tree-sitter-r>
> (commit `58a2279`, 2026-06-22), pinned for reproducible builds.
> **Upstream status:** already 0.25-clean — modern `tree-sitter-language` `LanguageFn`
> Rust binding and `parser.c` at ABI 14 (loads on the 0.25 runtime); verified against
> tree-sitter 0.25 with tree-sitter-cli 0.25.10. No grammar changes.
> **Changes vs upstream:** bumped the `tree-sitter` dev-dependency from `0.24.7` to
> `0.25` (test-only, needed to verify against the 0.25 runtime); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`, 12 R files) and `tests/smoke.rs`.
> **Rebase policy:** test-only diff, rebased onto upstream when it moves; retired if
> the pin is no longer needed.
> **Upstream PR:** pending (link will be added here once opened).

An R grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## R package

This grammar is available as an [R package](https://cran.r-project.org/web/packages/treesitter.r/index.html).

You'll also want the [R package providing bindings to tree-sitter](https://davisvaughan.github.io/r-tree-sitter/) itself.

## Rust bindings

This grammar is available as a [Rust crate on crates.io](https://crates.io/crates/tree-sitter-r).

## Node bindings

This grammar is available as an [npm package](https://www.npmjs.com/package/@davisvaughan/tree-sitter-r).

Note that it is currently listed as a scoped package under the name `@davisvaughan/tree-sitter-r`.
We are working with the npm team to gain ownership of the `tree-sitter-r` package.
Once that happens, we will move the npm package there instead.

## References

- [The R Draft Spec](https://cran.r-project.org/doc/manuals/r-release/R-lang.pdf)
- [gram.y](https://github.com/wch/r-source/blob/trunk/src/main/gram.y)

## Known deviations

This section describes known deviations from the R grammar.

### `]]` as a literal token

The following is valid R syntax, note how `]]` has been split over multiple lines.

```r
x[["a"]
]
```

This applies to `]]`, but not to `[[`, for example, this is not valid R syntax:

```r
x[
["a"]]
```

The technical reason for this is that [in the grammar](https://github.com/wch/r-source/blob/988774e05497bcf2cfac47bfbec59d551432e3fb/src/main/gram.y#L508) R treats `[[` as a single token, but `]]` is treated as two individual `]` tokens.
Treating `]]` as two individual `]` tokens allows whitespace, newlines, and even comments to appear between the two `]` tokens:

```r
x[["a"] # comment
]
```

While we'd like to precisely support the R grammar, it is also extremely useful to treat all of `(`, `)`, `[`, `]`, `[[`, and `]]` as literal tokens when using the tree-sitter grammar.
This allows you to treat call, subset, and subset2 nodes in the same way, since they all have exactly the same node structure.

Because treating `]]` as a literal token is so useful, and because we've never seen any R code "in the wild" written this way, this grammar does not allow whitespace, newlines, or comments between the two `]` tokens.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
