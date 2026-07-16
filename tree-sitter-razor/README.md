<!-- ────────────────────────────────────────────────────────────────── -->
<!-- FORK PROVENANCE                                                      -->
<!-- ────────────────────────────────────────────────────────────────── -->

> ## Fork provenance
>
> This is a **fork** of [`tris203/tree-sitter-razor`](https://github.com/tris203/tree-sitter-razor).
>
> - **Upstream:** https://github.com/tris203/tree-sitter-razor
> - **Forked commit:** `900f53dc6cc592f6e616adc2f732cb0f66fc9147` (2026-06-11)
> - **tree-sitter CLI:** 0.25.10 — regenerated at **ABI/LANGUAGE_VERSION 15**
> - **Upstream PR:** pending
>
> ### Why this fork exists — the fix
>
> Upstream errored on **bare top-level plain text**. A `.razor` file whose body
> is just prose — e.g. the default Blazor `Home.razor`/`Index.razor` line
> `Welcome to your new app.` — produced a top-level `(ERROR)` node, because the
> document rule (`compilation_unit`) only accepted Razor `_node`s and `@code`
> blocks at the top level, never free-standing text. Plain prose was valid only
> *inside* an HTML element. This broke a large share of real Blazor pages.
>
> **Change (surgical, one rule):** the top-level content repeat now also accepts
> plain text, aliased to a visible `text` node — mirroring how the grammar
> already handles interleaved text *inside* elements:
>
> ```js
> // compilation_unit, top-level content:
> //   before: repeat(choice($._node, $.razor_block))
> //   after:  repeat(choice($._node, $.razor_block, alias($._html_text, $.text)))
> ```
>
> The reused `_html_text` token excludes `<`, `>`, `&` and `@`, so `@`-transitions
> (Razor code), HTML tags and directives are unaffected — text can only start
> where none of those can.
>
> ### Validation
>
> - Upstream `tree-sitter test` still passes **100%** (82/82 — 79 original + 3
>   added for the top-level-text fix).
> - Repro `Welcome to your new app.` → **0 errors** (parses as `(compilation_unit (text))`).
> - Real corpus, [`dotnet/blazor-samples`](https://github.com/dotnet/blazor-samples)
>   (3058 `.razor` files): files containing an `ERROR` node dropped **428 → 362**
>   (66 files fixed), files with any error/missing node **652 → 588**, with
>   **0 newly-broken files** (verified by set-diffing the before/after error lists).
>
> ### Known limitation (not addressed — out of scope, would risk regressions)
>
> A separate, **pre-existing** upstream issue remains: a Razor *implicit*
> expression (`@identifier`) is parsed by the inherited C# expression grammar,
> which greedily consumes a following `<` as a relational operator. So
> `@currentCount` immediately followed by `<button …>`, or an attribute value
> like `value="<xref:@Link>"`, still errors. This is independent of the
> top-level-text fix (it errors even without any leading text) and lives in the
> shared C# expression rule; constraining it cleanly without introducing broad
> grammar ambiguity/regressions across the passing corpus was not achievable as a
> surgical change, so it is intentionally left untouched.
>
> ### Packaging changes
>
> - Modern `tree-sitter-language` `LanguageFn` Rust binding (already present
>   upstream; kept), external `scanner.c` still compiled by `build.rs`.
> - `tree-sitter` is a **dev-dependency only**.
> - Added `test/corpus_smoke/` (12 real-shaped `.razor` pages, all 0 errors) and
>   `tests/smoke.rs` (per-file error ratio < 5% + expected node kinds present).
> - No other grammar rules were rewritten (minimal diff vs upstream).
>
> ### Maintenance & support
>
> Provided **as-is**, with **no support** and **no SLA**. The fork authors are
> **not responsible for maintenance**. **PRs welcome**, but response is not
> guaranteed. Rebase policy: re-apply the single top-level-text change onto
> upstream as needed.

<!-- ────────────────────────────────────────────────────────────────── -->

# tree-sitter-razor

[![CI][ci]](https://github.com/tris203/tree-sitter-razor/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)

<!-- NOTE: uncomment these if you're publishing packages: -->
<!-- [![npm][npm]](https://www.npmjs.com/package/tree-sitter-razor) -->
<!-- [![crates][crates]](https://crates.io/crates/tree-sitter-razor) -->
<!-- [![pypi][pypi]](https://pypi.org/project/tree-sitter-razor/) -->

A Tree-sitter parser for razor files.

## References

<!-- NOTE: add the grammar's references here -->

[Razor syntax reference for ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-9.0)

[ci]: https://img.shields.io/github/actions/workflow/status/tris203/tree-sitter-razor/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
