# tree-sitter-clojure

> **Provenance (fork):** forked from <https://github.com/sogaiu/tree-sitter-clojure>
> (commit `e43eff8`, 2025-08-26).
> **Changes vs upstream:** added `tree-sitter.json` (required by
> tree-sitter-cli 0.25 for ABI 15); `parser.c` regenerated with
> tree-sitter-cli 0.25.10 (ABI 15); added a Rust binding in the modern
> `tree-sitter-language` `LanguageFn` shape (`Cargo.toml`,
> `bindings/rust/lib.rs`, `bindings/rust/build.rs`) — upstream intentionally
> ships no bindings; added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes — the
> grammar is intentionally reader-level (forms, not macro semantics), and an
> assessment over 12 synthetic samples confirmed the full reader syntax
> parses (quote/syntax-quote/unquote(-splicing), reader conditionals
> `#?`/`#?@`, tagged literals, metadata `^`/`#^`, anon fns `#()`, regex
> `#""`, var quote `#'`, deref `@`, namespaced maps `#::{}`/`#:ns{}`,
> auto-resolved keywords `::`, symbolic values `##Inf`, discard `#_`,
> comments and shebang lines).
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships equivalent 0.25 bindings.
> **Upstream PR:** pending (link will be added here once opened).

A tree-sitter grammar for Clojure and ClojureScript

## What the Repository Provides

This repository provides some files used to create various artifacts
(e.g. dynamic libraries) used for handling Clojure and ClojureScript
source code via tree-sitter.

Please see the [what and why document](doc/what-and-why.md) for
detailed information.

## Potential Changes

Changes may occur because:

1. There may be unanticipated important use cases we may want to
   account for
2. The grammar depends on tree-sitter which remains in flux (and is
   still pre 1.0)
3. It's possible we missed something or got something wrong about
   Clojure and we might want to remedy that

Note that previously tagged versions may work fine depending on the
use case.  See the [changelog](CHANGELOG.md) for details.

## Other Documents

There are some documents in the [`doc` directory](doc/) covering
topics such as:

* [Scope](doc/scope.md)
* [Limits](doc/limits.md)
* [Testing](doc/testing.md)
* [Uses](doc/use.md)

## Acknowledgments

Please see the [credits](doc/credits.md).


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
