tree-sitter-ragel
=================

> **Provenance (fork):** forked from <https://github.com/alemuller/tree-sitter-ragel>
> (commit `9d4c217`, 2022-01-01).
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); added `tree-sitter.json`
> (required for ABI-15 generation; metadata taken from upstream `package.json`/`Cargo.toml`);
> fixed the `repository` field in `Cargo.toml` (upstream pointed at the non-existent
> `tree-sitter/tree-sitter-ragel`); added a synthetic smoke-test corpus
> (`test/corpus_smoke/`) and `tests/smoke.rs`; added `.gitignore`. No grammar-rule changes.
> **Coverage note (upstream is WIP):** the grammar covers Ragel's FSM specification
> sub-language only — `machine` declarations, `include`/`import`, machine definitions
> (`=`) and instantiations (`:=`), the full expression algebra (`|`, `&`, `-`, `--`,
> `.`, `,`, repetition, negation, labels, groups), strings, numbers, regexes and
> character classes. It does **not** parse actions (`action ... { ... }`), action
> embedding operators (`>`, `@`, `%`, `$`, ...), `%%{ ... }%%` / `%%` delimiters,
> scanners (`|* ... *|`), `write` statements, or embedded host-language code, so
> complete real-world `.rl` files will produce errors.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

Ragel grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

[Ragel](https://www.colm.net/open-source/ragel/) is Adrian Thurston's state
machine compiler; `.rl` files describe finite state machines that are compiled
into host-language code.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
