# tree-sitter-swift (fork)

> **Provenance (fork):** forked from <https://github.com/alex-pinkus/tree-sitter-swift>
> (commit `28fe3a8a85586aa297524fe6164140b9521dcaff`, 2026-07-04) — the canonical,
> actively-maintained Swift grammar (crates.io `tree-sitter-swift`, ~4M downloads).
> The old "upstream stuck on 0.21" assessment is stale: upstream is current.
> **Changes vs upstream:** upstream does not commit `parser.c` (generates at release);
> this fork commits `src/parser.c` generated with tree-sitter-cli 0.25.10 (**ABI 15**,
> ~20 MB) so git consumers build without a generation step. Crate version aligned to
> `0.25.0` for this fork line (upstream crate is `0.7.3` — consumed only as a git-tag
> dependency; never publish to a registry under the upstream name); `tree-sitter`
> dev-dependency bumped 0.23 -> 0.25; edition 2018 -> 2021; added a synthetic smoke-test
> corpus (`test/corpus_smoke/`, 12 files: structs/classes/enums, optionals + guard,
> protocols/generics, closures, async/await + actors, throws/catch, extensions, pattern
> matching, property wrappers, result builders, raw/multiline strings) and
> `tests/smoke.rs`. External C scanner kept verbatim. Rust binding was already modern
> `LanguageFn`. No grammar-rule changes. Package name `tree-sitter-swift` kept verbatim.
> Upstream corpus: 250/250; smoke corpus: 0.00% error nodes.
> **Rebase policy:** regen/tests diff, rebased onto upstream when it moves; retired if
> upstream commits generated sources or ships an equivalent 0.25-line release.
> **Upstream PR:** n/a (upstream deliberately excludes generated sources).

![Parse rate badge](https://byob.yarr.is/alex-pinkus/tree-sitter-swift/parse_rate)
[![Crates.io badge](https://byob.yarr.is/alex-pinkus/tree-sitter-swift/crates_io_version)](https://crates.io/crates/tree-sitter-swift)
[![NPM badge](https://byob.yarr.is/alex-pinkus/tree-sitter-swift/npm_version)](https://www.npmjs.com/package/tree-sitter-swift)
[![Build](https://github.com/alex-pinkus/tree-sitter-swift/actions/workflows/top-repos.yml/badge.svg)](https://github.com/alex-pinkus/tree-sitter-swift/actions/workflows/top-repos.yml)

# tree-sitter-swift

This contains a [`tree-sitter`](https://tree-sitter.github.io/tree-sitter) grammar for the Swift programming language.

## Getting started

To use this parser to parse Swift code, you'll want to depend on either the Rust crate or the NPM package.

### Rust

To use the Rust crate, you'll add this to your `Cargo.toml`:

```
tree-sitter = "0.23.0"
tree-sitter-swift = "=0.7.3"
```

Then you can use a `tree-sitter` parser with the language declared here:

```
let mut parser = tree_sitter::Parser::new();
parser.set_language(tree_sitter_swift::language())?;

// ...

let tree = parser.parse(&my_source_code, None)
    .ok_or_else(|| /* error handling code */)?;
```

### Javascript

To use this from NPM, you'll add similar dependencies to `package.json`:

```
"dependencies: {
  "tree-sitter-swift": "0.7.3",
  "tree-sitter": "^0.22.1"
}
```

Your usage of the parser will look like:

```
const Parser = require("tree-sitter");
const Swift = require("tree-sitter-swift");

const parser = new Parser();
parser.setLanguage(Swift);

// ...

const tree = parser.parse(mySourceCode);
```

### Editing the grammar

With this package checked out, a common workflow for editing the grammar will look something like:

1. Make a change to `grammar.ts`.
2. Run `npm install && npm test` to see whether the change has had impact on existing parsing behavior. The default
   `npm test` target requires `valgrind` to be installed; if you do not have it installed, and do not wish to, you can
   substitute `tree-sitter test` directly.
3. Run `tree-sitter parse` on some real Swift codebase and see whether (or where) it fails.
4. Use any failures to create new corpus test cases.

## Contributions

All contributions to this repository are welcome.

If said contribution is to check generated files (e.g., `parser.c`) into the repository, be aware that your contribution will not be accepted. Make sure to read the [FAQ entry](https://github.com/alex-pinkus/tree-sitter-swift?tab=readme-ov-file#where-is-your-parserc) and the [prior](https://github.com/alex-pinkus/tree-sitter-swift/issues/362) [discussions](https://github.com/alex-pinkus/tree-sitter-swift/pull/315) and [compromises](https://github.com/alex-pinkus/tree-sitter-swift/issues/149) that have occurred already on this topic.

## Using tree-sitter-swift in Web Assembly

To use tree-sitter-swift as a language for the web bindings version tree-sitter, which will likely be a more modern version than the published node
module. [see](https://github.com/tree-sitter/tree-sitter/blob/master/lib/binding_web/README.md). Follow the instructions below

1. Install the node modules `npm install web-tree-sitter tree-sitter-swift`
2. Run the tree-sitter cli to create the wasm bundle
   ```sh
   $ npx tree-sitter build-asm ./node_modules/tree-sitter
   ```
3. Boot tree-sitter wasm like this.

```js
const Parser = require("web-tree-sitter");
async function run() {
  //needs to happen first
  await Parser.init();
  //wait for the load of swift
  const Swift = await Parser.Language.load("./tree-sitter-swift.wasm");

  const parser = new Parser();
  parser.setLanguage(Swift);

  //Parse your swift code here.
  const tree = parser.parse('print("Hello, World!")');
}
//if you want to run this
run().then(console.log, console.error);
```

## Frequently asked questions

### Where is your `parser.c`?

This repository currently omits most of the code that is autogenerated during a build. This means, for instance, that
`grammar.json` and `parser.c` are both only available following a build. It also significantly reduces noise during
diffs.

The side benefit of not checking in `parser.c` is that you can guarantee backwards compatibility. Parsers generated by
the tree-sitter CLI aren't always backwards compatible. If you need a parser, generate it yourself using the CLI; all
the information to do so is available in this package. By doing that, you'll also know for sure that your parser version
and your library version are compatible.

If you need a `parser.c`, and you don't care about the tree-sitter version, but you don't have a local setup that would
allow you to obtain the parser, you can just download one from a recent workflow run in this package. To do so:

- Go to the [GitHub actions page](https://github.com/alex-pinkus/tree-sitter-swift/actions) for this
  repository.
- Click on the "Publish `grammar.json` and `parser.c`" action for the appropriate commit.
- Go down to `Artifacts` and click on `generated-parser-src`. All the relevant parser files will be available in your
  download.


## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
