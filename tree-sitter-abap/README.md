# tree-sitter-abap

> **Provenance (fork):** forked from <https://github.com/mkoval1/tree-sitter-abap>
> (commit `c7604df`, 2024-06-29). Upstream ships no README; this file was created
> in the fork to carry provenance and gap notes.
> **Changes vs upstream:** Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> added a `tree-sitter.json` manifest (required by tree-sitter-cli 0.25 to emit ABI 15);
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`.
> **Grammar extensions vs upstream** (additive; no upstream rule was rewritten,
> only `_statement`/`_implementation_statement`, `if_statement` and
> `comparison_expression` gained alternatives):
> classic subroutines `FORM ... ENDFORM` (`form_definition`, `form_parameter`
> with `TABLES`/`USING`/`CHANGING`, `VALUE(...)`, `TYPE`/`LIKE`/`STRUCTURE`
> typing) and `PERFORM` calls (`perform_statement`, incl. `PERFORM f(prog)`,
> `PERFORM f IN PROGRAM prog` and `IF FOUND`); `ELSEIF`/`ELSE` branches on
> `if_statement` (`elseif_block`, `else_block`); `CASE ... WHEN ... ENDCASE`
> (`case_statement`, `when_block`, incl. `WHEN a OR b` and `WHEN OTHERS`);
> ordering comparison operators `>` `<` `>=` `<=` `GT` `LT` `GE` `LE` in
> `comparison_expression`. Covered by `test/corpus/{form_definition,
> perform_statement,case_statement,if_else_statement}.txt` and smoke files
> 13/14.
> **Rebase policy:** binding modernization plus additive grammar extensions
> (listed above), rebased onto upstream when it moves; extensions dropped in
> favour of upstream equivalents if upstream gains them.
> **Upstream PR:** pending (link will be added here once opened).

SAP ABAP grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).
Work-in-progress grammar (~80 rules) focused on the OO subset
(classes, methods, interfaces) plus core imperative statements and, since
this fork, classic FORM/PERFORM subroutines and CASE/ELSE branching.

## Closed in this fork (were upstream gaps in commit `c7604df`)

- Classic **FORM ... ENDFORM / PERFORM** subroutines.
- **CASE / WHEN / ENDCASE** (incl. `WHEN a OR b`, `WHEN OTHERS`).
- **ELSE / ELSEIF** branches on `if_statement`.
- Ordering **comparison operators** `>`, `<`, `>=`, `<=`, `GT`, `LT`,
  `GE`, `LE` (in addition to upstream's `=`, `EQ`, `<>`, `NE`).

## GAPS (known upstream limitations, verified against commit `c7604df`)

The grammar is partial. Constructs **not** supported:

- **`BETWEEN`, `CP`, `CO`, `CA`, `IN`** and other predicate operators do
  not parse (`IS INITIAL`, `NOT`, `AND`, `OR` are supported).
- **No string templates `|...|`**; only `'...'` character literals.
- **No INTERFACES statement inside a class** (interface implementation);
  only standalone `INTERFACE ... ENDINTERFACE` declarations parse.
- **Method-call results cannot be assigned**: calls such as
  `lv = obj->meth( ... ).` do not parse; method/function calls are
  statements only (`obj->meth( ... ).`, `cls=>meth( ... ).`,
  `CALL FUNCTION '...'`). Assignment RHS is limited to literals,
  data objects and arithmetic expressions.
- **Only the obsolete `SELECT ... INTO TABLE` form** of Open SQL; the
  modern comma-separated `SELECT ... INTO @...` syntax is not covered.
- **No DO/WHILE loops**; only `LOOP AT ... ENDLOOP`.
- Various further statements (MODIFY, DELETE, SORT, CONCATENATE, SPLIT,
  MESSAGE, AUTHORITY-CHECK, events, etc.) are absent.

The synthetic smoke corpus in `test/corpus_smoke/` uses only supported
constructs; files carry comments where an unsupported construct was
replaced by a supported one.

## Licensing note

Upstream contains no LICENSE file; its `Cargo.toml`/`pyproject.toml`
declare MIT while `package.json` declares ISC. Kept verbatim; needs
upstream clarification before publishing.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
