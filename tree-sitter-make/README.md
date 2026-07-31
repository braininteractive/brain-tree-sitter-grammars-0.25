# tree-sitter-make (fork)

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-make>
> (commit `70613f3d812cbabbd7f38d104d60a409c4008b43`, 2026-02-26).
> **Changes vs upstream:** upstream ships NO Rust crate — full Cargo.toml + LanguageFn
> bindings built fork-side; parser already ABI 15; added a synthetic smoke-test corpus
> (test/corpus_smoke/, 10 files) and tests/smoke.rs. Upstream corpus: 117/117; smoke
> corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-make
Tree-sitter-make is a Make parser intended to be used for syntax highlighting.

## Missing features
- [ ] Support to custom .RECIPEPREFIX
- [ ] Load directive

This parser uses GNUMakefile documentation as reference. Others makefile formats
might have features not implemented by this grammar. Feel free to open an issue
with a feature request or do a pull request to extend this grammar to support
other makefiles formats.

## Reference
* [GNU Make manual](https://www.gnu.org/software/make/manual/html_node/index.html)


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
