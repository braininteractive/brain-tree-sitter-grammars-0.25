> **Comma-less multiline entities (2026-07-17, fork.5):** entity arguments may now be
> separated by line breaks as well as commas (`Foo\Bar(\n  arg1\n  arg2\n)`) — the
> external scanner is consulted at separator positions inside the parens. Previously
> adjacent args silently fused into one plain_scalar. Corpus 11/11 incl. regression test.

# tree-sitter-neon

> **Provenance (fork):** forked from <https://github.com/shubhamdhaboya/tree-sitter-neon>
> (commit `20a06e9`, 2026-05-29).
> **Changes vs upstream:** added the previously-missing Rust crate — `Cargo.toml`
> (version `0.25.0`, `tree-sitter-language` `LanguageFn` binding, `tree-sitter` as a
> dev-dependency), `bindings/rust/lib.rs` (`pub const LANGUAGE` + `NODE_TYPES` +
> `HIGHLIGHTS_QUERY`), and `bindings/rust/build.rs` (compiles `parser.c` **and** the
> external `scanner.c`); regenerated `parser.c`/`node-types.json` with tree-sitter-cli
> 0.25.10 (ABI 15); added a synthetic smoke-test corpus (`test/corpus_smoke/`, 12 files)
> and `tests/smoke.rs`. No grammar-rule changes; upstream `queries/highlights.scm` and
> `test/corpus/` preserved verbatim.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 Rust binding.
> **Upstream PR:** pending.

A [tree-sitter](https://tree-sitter.github.io/) grammar for
[NEON](https://ne-on.org/) (Nette Object Notation), the indentation-based
configuration format used by the [Nette](https://nette.org/) framework.

## Features

- Block mappings and sequences (indentation sensitive)
- Inline (flow) mappings `{ … }` and sequences `[ … ]`
- Entity / service definitions — `Class\Name(arg, key: value)`
- Scalars: quoted/bare strings, numbers (dec/hex/oct/bin), booleans, null
- `@references` and `%parameter%` interpolation
- `#` comments

Indentation (`INDENT` / `DEDENT` / `NEWLINE`) is produced by the external
scanner in [`src/scanner.c`](src/scanner.c).

Also supported: `:` **and** `=` key separators, sequences of mappings
(`- key: value` with aligned continuations), chained entities
(`Foo(a) Bar(b)`), triple-quoted multiline strings, and multiline / multiline
flow collections.

### Known limitation

Multiline entities that rely on **comma-less** newline separation do *not*
parse:

```neon
svc: Column(
	type: int      # no trailing comma — not supported
	nulls: yes
)
```

Inside flow context (`()` `[]` `{}`) newlines are treated as whitespace, so an
explicit separator is required. Add commas and it parses:

```neon
svc: Column(
	type: int,
	nulls: yes,
)
```

## Development

```sh
npm install
tree-sitter generate
tree-sitter test
tree-sitter parse examples/sample.neon
```

## Use in Zed

This grammar is consumed by the companion Zed extension. See its
`extension.toml` — during local development it points here via a `path`, and
for publishing it pins this repository by `commit`.

## License

MIT — see [LICENSE](LICENSE).

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
