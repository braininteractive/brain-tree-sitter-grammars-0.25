
# tree-sitter-vim

> **Provenance (fork):** forked from <https://github.com/tree-sitter-grammars/tree-sitter-vim>
> (commit `039c8d0`, 2026-07-12).
> **Changes vs upstream:** Rust binding conformed to the `tree-sitter-language`
> `LanguageFn` API (`pub const LANGUAGE`); `tree-sitter` kept as a dev-dependency only;
> `parser.c` regenerated with tree-sitter-cli 0.25.10 (ABI 15); `src/node-types.json`
> committed; external `scanner.c` still compiled by `build.rs`; added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25 binding.
> **Upstream PR:** pending (link will be added here once opened).


[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-vim/actions/workflows/ci.yaml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)

A tree-sitter parser for Vimscript files.

## References

* [Write a Vim script](https://neovim.io/doc/user/usr_41.html)

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-vim/main.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
