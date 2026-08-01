# tree-sitter-ssh-config (fork)

> **Provenance (fork):** forked from <https://github.com/ObserverOfTime/tree-sitter-ssh-config>
> (commit `0c35b243392268f48fd096607da192d76c843398`, 2026-07-24).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0; added a synthetic smoke-test corpus (test/corpus_smoke/, 10 files) and
> tests/smoke.rs. Upstream corpus: 11/11; smoke corpus: 0.00% error nodes under the
> cargo <5% gate.
> **Rebase policy:** conform/tests diff, rebased onto upstream when it moves.

# tree-sitter-ssh-config

[![CI][ci]](https://github.com/tree-sitter-grammars/tree-sitter-ssh-config/actions/workflows/ci.yml)
[![discord][discord]](https://discord.gg/w7nTvsVJhm)
[![matrix][matrix]](https://matrix.to/#/#tree-sitter-chat:matrix.org)

A tree-sitter parser for OpenSSH client configuration files.

## References

* [ssh_config(5)](https://man.openbsd.org/ssh_config)

## TODO

* [x] Support `ssh_config`
* [ ] Support `sshd_config`

## Editors

- [x] Neovim
- [ ] Helix _(has alternative)_
- [ ] Emacs
- [ ] Zed

[ci]: https://img.shields.io/github/actions/workflow/status/tree-sitter-grammars/tree-sitter-ssh-config/ci.yml?logo=github&label=CI
[discord]: https://img.shields.io/discord/1063097320771698699?logo=discord&label=discord
[matrix]: https://img.shields.io/matrix/tree-sitter-chat%3Amatrix.org?logo=matrix&label=matrix


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
