# tree-sitter-tsql

> **Provenance (fork):** forked from <https://github.com/Crary-Systems/tree-sitter-tsql>
> (commit `443d2bc`, 2025-05-26).
> **Changes vs upstream:** parser regenerated with tree-sitter-cli 0.25.10 (ABI 14 -> 15,
> added `tree-sitter.json`); Rust binding modernized to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` moved to a dev-dependency;
> grammar renamed `TSQL` -> `tsql` (the C symbol is now `tree_sitter_tsql`, which also
> fixes the upstream Rust binding that referenced the wrong symbol); removed git-tracked
> case-colliding duplicate C/Swift headers; **substantial grammar extension** (upstream
> covered only SELECT-without-WHERE, EXEC and GO — see "Grammar extension" below);
> two lexer fixes (single-character identifiers, bracketed identifiers with
> digits/spaces); added a synthetic smoke-test corpus (`test/corpus_smoke/`),
> a known-gaps corpus (`test/corpus_known_gaps/`) and `tests/smoke.rs`; upstream's
> 252 corpus tests still pass (expectations regenerated where new named nodes appear).
> **Rebase policy:** this fork extends the grammar significantly; if upstream moves,
> changes will be merged manually rather than rebased mechanically.
> **Upstream PR:** pending (link will be added here once opened).

T-SQL grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).
Adapted from [this T-SQL grammar](https://github.com/antlr/grammars-v4/tree/master/sql/tsql).

## Grammar extension (this fork)

Upstream (~20-30% complete) parsed only: `SELECT` (no `WHERE`/`JOIN`/`ORDER BY`),
`EXEC`, `GO`, and a large built-in/window function library. This fork adds, following
the same antlr `TSqlParser.g4` rule names the upstream is derived from:

- **Expressions**: binary/unary operators with precedence, parenthesized expressions,
  `CASE` (simple + searched), scalar subqueries, multi-part column names (`a.b.c.d`)
- **Search conditions**: `AND`/`OR`/`NOT`, comparisons, `BETWEEN`, `IN` (list or
  subquery), `LIKE`/`ESCAPE`, `IS [NOT] NULL`, `EXISTS`
- **SELECT**: `WHERE`, `HAVING`, statement-level `ORDER BY`, `TOP (n) [PERCENT]
  [WITH TIES]`, `DISTINCT`/`ALL`, `SELECT ... INTO`, qualified `t.*`, table aliases,
  table hints (`WITH (NOLOCK)`), `INNER`/`LEFT`/`RIGHT`/`FULL`/`CROSS JOIN`,
  derived tables, comma-separated table sources, `UNION [ALL]`/`EXCEPT`/`INTERSECT`,
  CTEs (`WITH ... AS (...)`)
- **DML**: `INSERT` (`VALUES`, `SELECT`, `EXEC`, `DEFAULT VALUES`), `UPDATE`
  (incl. `FROM`), `DELETE` (incl. `TOP`), `MERGE` (`WHEN [NOT] MATCHED [BY
  TARGET|SOURCE]` with `UPDATE`/`DELETE`/`INSERT` actions)
- **DDL**: `CREATE TABLE` (column definitions, `IDENTITY`, `NULL`/`NOT NULL`,
  `DEFAULT`, `PRIMARY KEY`/`UNIQUE`/`FOREIGN KEY`/`CHECK` column + table
  constraints), `CREATE [OR ALTER] PROCEDURE` (params with defaults and
  `OUTPUT`/`READONLY`, `WITH RECOMPILE|ENCRYPTION|EXECUTE AS`), `CREATE [OR ALTER]
  VIEW`, `CREATE [UNIQUE] [NON]CLUSTERED INDEX ... INCLUDE ... WHERE`,
  `ALTER TABLE ADD / DROP COLUMN / DROP CONSTRAINT`, `DROP TABLE/PROC/VIEW/INDEX/
  FUNCTION [IF EXISTS]`
- **Control flow**: `BEGIN...END`, `IF/ELSE`, `WHILE`, `BREAK`, `CONTINUE`,
  `RETURN`, `BEGIN TRY/CATCH`, `PRINT`, `THROW`, `RAISERROR`
- **Variables/session**: `DECLARE` (scalar with initializers, table variables),
  `SET @var = expr` (incl. compound assignment), `SET <option> ON|OFF`,
  `SET TRANSACTION ISOLATION LEVEL`
- **Transactions**: `BEGIN/COMMIT/ROLLBACK/SAVE TRAN[SACTION]`
- **Misc**: `USE`, `--` and `/* */` comments, `UNIQUEIDENTIFIER`/`XML`/`SYSNAME`
  types

## GAPS (still unsupported)

Samples for the biggest gaps live in `test/corpus_known_gaps/` (with their own
README) and are excluded from the smoke test:

- Cursors (`DECLARE CURSOR`, `OPEN`, `FETCH`, `CLOSE`, `DEALLOCATE`)
- `CREATE FUNCTION` (all forms) and `CREATE TRIGGER`
- `PIVOT`/`UNPIVOT`, `CROSS/OUTER APPLY`, table-valued functions in `FROM`
- `OUTPUT` clause on DML; `ORDER BY ... OFFSET ... FETCH`
- `WAITFOR`, `GOTO`/labels
- `GRANT`/`REVOKE`/`DENY` and other security statements
- `ALTER TABLE ... ALTER COLUMN` (only ADD/DROP are supported)
- `ALL`/`SOME`/`ANY` comparison predicates
- `FOR XML/JSON`, `OPTION (...)` query hints
- `BULK INSERT`, `OPENROWSET`/`OPENQUERY`, linked-server `AT DATA_SOURCE`
- Full-text predicates (`CONTAINS`, `FREETEXT`)
- Computed columns, filegroup/partition options in `CREATE TABLE`
- XML/UDT method calls beyond upstream's `udt_elem`, `WITHIN GROUP`,
  `AT TIME ZONE`
- Reserved/builtin keywords (e.g. `RANK`, `LEFT`) cannot be used as plain
  identifiers/aliases; `GO` inside identifiers-only contexts is always a batch
  separator
- Collation names are single identifiers only; `EXECUTE AS` statement (only the
  procedure option form is parsed)

## Developing

```
nix-shell
tree-sitter generate
tree-sitter build
tree-sitter test
```

## Errata

- Configuration Functions must be all caps or will be parsed as a LOCAL_ID. Lexer issue.

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
