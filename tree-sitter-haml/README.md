# tree-sitter-haml (fork)

> **Provenance (fork):** forked from <https://github.com/vitallium/tree-sitter-haml>
> (commit `3ea1526`, 2026-02-03).
> **Changes vs upstream:** pin-style — already ABI 15 + LanguageFn; version aligned to
> 0.25.0, dev-dep pinned 0.25; added a synthetic smoke-test corpus (test/corpus_smoke/,
> 10+ files) and tests/smoke.rs. Package name `tree-sitter-haml` kept verbatim. Upstream
> corpus: 89/89; smoke corpus: 0.00% error nodes under the cargo <5% gate.
> **Rebase policy:** conform/tests-only diff, rebased onto upstream when it moves; retired
> if upstream ships an equivalent 0.25-line release.
> **Upstream PR:** pending where noted; n/a for pure pins.

# tree-sitter-haml

This is a general tree-sitter parser grammar for [the HAML templating language](https://haml.info/).

## Development

### Building

To build the grammar, run:

```shell
npm run build
```

### Registering the grammar

If you want the `tree-sitter` CLI to pick up this grammar after building it, add the repository to your parser directories:

1. Ensure you have a config file (`tree-sitter init-config` creates `~/.config/tree-sitter/config.json` if it is missing).
2. Edit that file and include the absolute path to this repo in the `parser-directories` array, for example:

   ```json
   {
     "parser-directories": [
       "/Users/you/path/to/tree-sitter-haml"
     ]
   }
   ```

Once registered, commands like `tree-sitter parse` and `tree-sitter highlight` will automatically load the HAML parser from this build.

### Testing

To test the grammar, run:

```shell
npm run test
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Credits

- [The `pug` grammar](https://github.com/zealot128/tree-sitter-pug/blob/master/README.md)

## References

- [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- [Tree-sitter documentation](https://tree-sitter.github.io/tree-sitter/creating-parsers)
- [HAML](https://haml.info/)
- [HAML documentation](https://haml.info/docs/yardoc/file.REFERENCE.html)


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
