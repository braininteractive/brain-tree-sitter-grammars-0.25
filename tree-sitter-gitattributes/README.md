# tree-sitter-gitattributes (fork)

> **Provenance (fork):** forked from <https://github.com/ObserverOfTime/tree-sitter-gitattributes>
> (commit `1b7af09d45b579f9f288453b95ad555f1f431645`, 2025-08-17).
> **Changes vs upstream:** ABI 14 -> 15 regen; version aligned to 0.25.0; added a
> synthetic smoke-test corpus (test/corpus_smoke/, 10 files) and tests/smoke.rs.
> Upstream corpus: 11/11; smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves; retired if
> upstream ships an equivalent 0.25-line release.

# tree-sitter-gitattributes

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-gitattributes/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)
[![npm][npm]](https://www.npmjs.com/package/tree-sitter-gitattributes)
[![crates][crates]](https://crates.io/crates/tree-sitter-gitattributes)
[![pypi][pypi]](https://pypi.org/project/tree-sitter-gitattributes/)

A tree-sitter parser for `.gitattributes` files.

## References

* [gitattributes Documentation](https://git-scm.com/docs/gitattributes)
* [gitignore Documentation (Pattern Format)](https://git-scm.com/docs/gitignore#_pattern_format)
* [git source code (`attr.c`)](https://github.com/git/git/blob/master/attr.c)
* [git source code (`wildmatch.c`)](https://github.com/git/git/blob/master/wildmatch.c)
* [ANSI-C Quoting](https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html)
* [Character Classes and Bracket Expressions](https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html)

## Editors

- [x] Neovim
- [ ] Helix _(has alternative)_
- [x] Emacs
- [ ] Zed

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-gitattributes/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix
[npm]: https://img.shields.io/npm/v/tree-sitter-gitattributes?logo=npm
[crates]: https://img.shields.io/crates/v/tree-sitter-gitattributes?logo=rust
[pypi]: https://img.shields.io/pypi/v/tree-sitter-gitattributes?logo=pypi&logoColor=ffd242


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
