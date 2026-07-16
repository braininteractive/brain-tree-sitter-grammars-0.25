# tree-sitter-jinja

> **Provenance (fork):** forked from <https://github.com/cathaysia/tree-sitter-jinja>
> (commit `c213d3745ccdcaaa858869181c7b1bf9557a025f`, 2026-07-02).
> **Changes vs upstream:** Rust bindings of both crates modernized to the
> `tree-sitter-language` `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter`
> moved to a dev-dependency; both parsers regenerated with tree-sitter-cli
> 0.25.10 (ABI 15); added synthetic Flask/Django smoke-test corpora
> (`tree-sitter-jinja/test/corpus_smoke/`, 12 files;
> `tree-sitter-jinja_inline/test/corpus_smoke/`, 10 files) and `tests/smoke.rs`
> in each crate. No grammar-rule changes. Upstream queries
> (`queries/highlights.scm`, `queries/injections.scm`) preserved verbatim.
> **Layout:** this is upstream's monorepo layout — two independent crates:
> `tree-sitter-jinja` (block grammar: `{% ... %}`, `{{ ... }}`, `{# ... #}`)
> exposing `tree_sitter_jinja::LANGUAGE`, and `tree-sitter-jinja-inline`
> (line-statement grammar: `# for ...`) exposing
> `tree_sitter_jinja_inline::LANGUAGE`.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).

## Known gaps (fork audit, 2026-07-16)

The following valid Jinja2 constructs produce ERROR nodes with the current
(upstream) grammar rules. They are documented here rather than patched, to keep
the fork a minimal binding-only diff:

- Named `endblock`: `{% endblock content %}` (bare `{% endblock %}` works).
- `scoped` block modifier: `{% block item scoped %}` (`required` works).
- Slice subscripts: `{{ items[:3] }}`, `{{ text[1:200] }}` (plain and negative
  indexing works).
- Dotted macro names in `{% call %}`: `{% call ui.card(x) %}` (plain
  `{% call card(x) %}` and `{% call(item) card(x) %}` work).
- `*args` / `**kwargs` in macro signatures and at call sites:
  `{% macro f(*args, **kwargs) %}`, `{{ url_for(e, **view_args) }}`.
- Chained ternaries: `{{ 'a' if x else 'b' if y else 'c' }}` (single
  `a if cond else b` works).

Covered and verified against realistic Flask/Django templates: template
inheritance (`extends`/`block`/`super()`), `include` (with
`ignore missing` / `with context` / template lists), `import` / `from ... import
... as`, macros with default arguments and `caller()`, `call` blocks, `filter`
blocks, `set` statements and `set ... endset` blocks, `for ... else` with
inline `if` filters, `recursive` loops and all `loop.*` attributes, full
`if/elif/else`, filters with arguments (`|truncate(80, true)`), tests
(`is defined`, `is divisibleby 3`, `is not none`, ...), `in` / `not in`, all
arithmetic/comparison/logic operators, `~` concatenation, dict/list/tuple
literals, `{# ... #}` and `##` comments, whitespace control (`{%-`, `-%}`,
`{%+`, `+%}`), `{% raw %}`, `{% trans %}` / `{% pluralize %}` (i18n),
`{% autoescape %}`, `{% do %}`, `namespace()`, and Jinja line statements
(via the separate `jinja_inline` grammar).

---

![PyPI - Version](https://img.shields.io/pypi/v/tree-sitter-jinja3?label=tree-sitter-jinja(pypi)&color=blue)
![PyPI - Version](https://img.shields.io/pypi/v/tree-sitter-jinja3_inline?label=tree-sitter-jinja3_inline(pypi)&color=blue)
![Crates.io Version](https://img.shields.io/crates/v/tree-sitter-jinja?label=tree-sitter-jinja(crates.io))
![Crates.io Version](https://img.shields.io/crates/v/tree-sitter-jinja_inline?label=tree-sitter-jinja_inline(crates.io))

[Jinja](https://jinja.palletsprojects.com/en/3.1.x/templates/) and [Jinja inline](https://jinja.palletsprojects.com/en/stable/templates/#line-statements) grammar for [tree-sitter](https://tree-sitter.github.io/).

> [!NOTE]
> inline statement starts with `# `.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
