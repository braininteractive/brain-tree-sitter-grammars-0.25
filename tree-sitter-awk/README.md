# tree-sitter-awk (fork)

> **Provenance (fork):** forked from <https://github.com/Beaglefoot/tree-sitter-awk>
> (commit `34bbdc7cce8e803096f47b625979e34c1be38127`, 2024-11-02).
> **Changes vs upstream:** ABI 14 -> 15 regen; tree-sitter.json added; legacy binding
> rewritten to LanguageFn. Replaces bash-surrogate treatment of .awk files; added a
> synthetic smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs.
> Upstream corpus: 117/117; smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

tree-sitter-awk
================

[![tests](https://github.com/Beaglefoot/tree-sitter-awk/actions/workflows/tests.yml/badge.svg)](https://github.com/Beaglefoot/tree-sitter-awk/actions/workflows/tests.yml)
[![npm](https://img.shields.io/npm/v/tree-sitter-awk)](https://www.npmjs.com/package/tree-sitter-awk)

GNU AWK grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).


### Development

Install the dependencies:

    yarn

Although grammar is basically a JS file you can still benefit from types (references, go to implementation, renames...).

To build types in watch mode:

    yarn types:watch

Test:

    yarn test

To ease generating test results create a fragment code in some file and run:

    npx tree-sitter parse <your_file> | yarn -s trim

You can simplify process further by piping result into `xclip` or alike.

### References

* [GAWK Man page](https://www.man7.org/linux/man-pages/man1/gawk.1.html)
* [Original Bison grammar](http://git.savannah.gnu.org/cgit/gawk.git/tree/awkgram.y)


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
