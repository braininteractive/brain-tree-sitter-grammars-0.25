# Tree-sitter grammar fork playbook (tree-sitter 0.25)

Reference implementations (already completed, follow them exactly):
- `/Users/younes/Documents/PROJECTS/BRAIN_AST_BUILDER/tree-sitter-json5`
- `/Users/younes/Documents/PROJECTS/BRAIN_AST_BUILDER/tree-sitter-dockerfile`

## Hard rules
1. Work in `/Users/younes/Documents/PROJECTS/BRAIN_AST_BUILDER/<repo-name>`.
2. **Do NOT push to GitHub, do not run `gh`** — commit + tag locally only (`v0.25.0-fork.1`). Publishing happens later, centrally.
3. **Corpus files must be synthetic** (written by you, hello-world/sample style) **or copied from the grammar's own upstream test corpus**. Never from any other local directory on this machine. Never reference any consuming/downstream project anywhere.
4. **Minimal diff vs upstream**: ABI bump + binding modernization + tests + README header only. No grammar-rule rewrites unless the worklist item explicitly allows it.
5. Never build a grammar from scratch. If the upstream turns out to be empty/toy/unusable, STOP and report that finding instead.
6. Preserve LICENSE and attribution verbatim.

## Toolchain (already installed)
`tree-sitter` CLI 0.25.10 on PATH, Rust stable (cargo 1.91), clang. `npm i` inside the repo if `tree-sitter generate` needs node deps (e.g. a DSL helper the grammar.js requires).

## Standard steps per grammar
1. `git clone <upstream>` into the workspace dir. Record `git log -1 --format='%H %ci'`.
2. `tree-sitter generate` (must exit 0). Confirm `grep LANGUAGE_VERSION src/parser.c` shows 15. Commit generated files.
   - If generate fails on old grammar.js idioms, apply the smallest possible fix and document it in the README header.
3. **Cargo.toml**: version `0.25.0`, edition `2021`,
   `[dependencies] tree-sitter-language = "0.1"`, `[build-dependencies] cc = "1.0"`, `[dev-dependencies] tree-sitter = "0.25"`.
   No `tree-sitter` in `[dependencies]`. Keep name/license/repository fields from upstream.
4. **bindings/rust/lib.rs** — modern shape (copy from the json5 reference, adjust names):
   ```rust
   use tree_sitter_language::LanguageFn;
   extern "C" { fn tree_sitter_<lang>() -> *const (); }
   pub const LANGUAGE: LanguageFn = unsafe { LanguageFn::from_raw(tree_sitter_<lang>) };
   pub const NODE_TYPES: &str = include_str!("../../src/node-types.json");
   ```
   Plus a `#[cfg(test)]` load test and a doc-example that parses a tiny valid snippet. Do NOT keep `pub fn language()`.
5. **build.rs**: keep upstream's; ensure external scanner (`scanner.c`/`scanner.cc`) stays compiled if present.
6. **Smoke corpus**: ≥10 (aim 12) files under `test/corpus_smoke/`, covering the language's real-world surface. Synthetic or from upstream's own `test/corpus`.
7. **tests/smoke.rs**: copy the structure from the reference repos —
   (a) ≥10 files parse with error+missing node ratio < 5% per file (assert root node kind too);
   (b) expected top-level node kinds present across the corpus (pick 4–12 kinds meaningful for the language from `src/node-types.json`).
8. `cargo test` — all green. Then measure per-file ratios with `tree-sitter parse` and record them.
9. **README**: prepend a provenance block (copy style from the dockerfile reference): upstream URL + forked commit + date, exact list of changes, rebase policy, "Upstream PR: pending".
10. `git add -A && git commit` (message style: see reference repos; end with `Co-Authored-By: brainlet <contact@brainlet.sh>`), then `git tag v0.25.0-fork.1`.

## Addendum (brief v3 requirements)
- Ensure `src/node-types.json` is committed (it is a `tree-sitter generate` output).
- Report a **"0.26-ready?"** flag per grammar: yes if regenerated at ABI 15 with a `tree-sitter.json` present (loads on newer runtimes); no/unknown otherwise, with reason.
- Do NOT fork grammars that are already maintained and 0.25-ready just to bump versions (maintenance liability, zero gain) — adopt-as-is and say so in your report.
- Never touch/reference anything outside public grammar repos + public community query files. Preserve upstream `queries/injections.scm` in template-language grammars.
- VERSIONS.md manifest is assembled centrally — just report the data.

## Report back (final message, per grammar)
- upstream repo + forked commit hash/date
- tree-sitter-cli version used (0.25.10) and resulting ABI
- what you changed (files, and any grammar.js fixes with justification)
- corpus source (synthetic / upstream corpus) and per-file error-node ratios
- cargo test summary
- known gaps / language features not covered (esp. for WIP grammars — be explicit)
- anything that blocks publishing or needs a human decision
