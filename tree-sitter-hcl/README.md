# tree-sitter-hcl

> **Provenance (fork):** forked from <https://github.com/MichaHoffmann/tree-sitter-hcl>
> (commit `64ad627`, 2026-01-17), pinned for reproducible builds.
> **Upstream status:** already 0.25-clean — modern `tree-sitter-language` `LanguageFn`
> Rust binding and `parser.c` at ABI 15; verified against tree-sitter 0.25 with
> tree-sitter-cli 0.25.10. No binding or grammar changes were needed.
> **Changes vs upstream:** added a synthetic smoke-test corpus
> (`test/corpus_smoke/`, 12 Terraform/HCL files) and `tests/smoke.rs` only.
> **Rebase policy:** test-only diff, rebased onto upstream when it moves; retired if
> the pin is no longer needed.
> **Upstream PR:** pending (link will be added here once opened).

tree-sitter grammar for the [HCL](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md) language

## Try It Out

Try the parser in the [playground](https://tree-sitter-grammars.github.io/tree-sitter-hcl/)

## Example

Highlighting `example/example.hcl`:

![Highlighting Example](https://i.imgur.com/yUJ0ybK.png)

## Developing

It is recommended to use `nix` to fulfill all development dependencies. To activate the development environment simply run `nix-shell` in the project root.

## Running Tests

To run tests simply run `nix-shell --run 'tree-sitter test'`.

## Compliance

The directory `example/real_world_stuff` contains a corpus of hcl files that I found with the github query `language:HCL` for users `coreos`, `hashicorp`, `oracle` and `terraform-community-modules`.

```bash
tree-sitter parse --quiet --stat example/real_world_stuff/*/*

Total parses: 1892; successful parses: 1892; failed parses: 0; success percentage: 100.00%
```

## Fuzzing

See the [fuzzing repo for this parser](https://github.com/MichaHoffmann/tree-sitter-hcl-fuzz)

## Attributions

Pages were copied from https://github.com/m-novikov/tree-sitter-sql

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
