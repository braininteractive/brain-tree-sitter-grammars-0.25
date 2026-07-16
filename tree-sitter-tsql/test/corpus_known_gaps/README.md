# Known-gap corpus (NOT parsed by the smoke test)

These synthetic T-SQL samples exercise constructs the grammar does **not**
support yet. They are kept out of `test/corpus_smoke/` on purpose: the smoke
test (`tests/smoke.rs`) asserts an error-node ratio below 5% and every file in
this directory exceeds that today. When a construct gains grammar support,
move its sample into `test/corpus_smoke/`.

| File | Unsupported constructs |
| --- | --- |
| `cursors.sql` | `DECLARE ... CURSOR`, `OPEN`, `FETCH ... INTO`, `CLOSE`, `DEALLOCATE` |
| `create_function.sql` | `CREATE FUNCTION` (scalar/inline/multi-statement TVFs) |
| `pivot_apply.sql` | `PIVOT` / `UNPIVOT`, `CROSS APPLY` / `OUTER APPLY`, table-valued functions in `FROM` |
| `output_offset.sql` | `OUTPUT` clause on DML, `ORDER BY ... OFFSET ... FETCH` pagination |
| `goto_waitfor.sql` | `WAITFOR DELAY/TIME`, `GOTO` and statement labels |
| `security.sql` | `GRANT` / `REVOKE` / `DENY` (all permission statements) |
| `alter_column_trigger.sql` | `ALTER TABLE ... ALTER COLUMN`, `CREATE TRIGGER` |
| `misc_advanced.sql` | `ALL` / `SOME` / `ANY` comparison predicates, `FOR XML/JSON`, `OPTION (...)` query hints |

Additional gaps with no sample file here (see the README GAPS section for the
full list): common table expression recursion is parsed but not semantically
distinguished, `CREATE TABLE` filegroup/partition options, computed columns,
`MERGE` `OUTPUT`, `SELECT ... FOR UPDATE OF`, `BULK INSERT`, `OPENROWSET` /
`OPENQUERY`, full-text predicates (`CONTAINS`, `FREETEXT`), XML methods,
`WITHIN GROUP`, `AT TIME ZONE`, and using reserved/builtin keywords as plain
identifiers.
