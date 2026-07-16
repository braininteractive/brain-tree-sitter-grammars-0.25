# tree-sitter-jsp

> **Provenance (fork):** forked from <https://github.com/karlvr/tree-sitter-jsp>
> (commit `5cec1a3`, 2026-04-01).
> **Changes vs upstream:** added a Rust crate (`Cargo.toml`,
> `bindings/rust/lib.rs` with the `tree-sitter-language` `LanguageFn` API,
> `bindings/rust/build.rs` compiling `src/parser.c` and the external
> `src/scanner.c`) — upstream ships Swift/C bindings only; enabled
> `bindings.rust` in `tree-sitter.json`; `parser.c` regenerated with
> tree-sitter-cli 0.25.10 (ABI 15, unchanged output); added a synthetic
> smoke-test corpus (`test/corpus_smoke/`) and `tests/smoke.rs`; added
> `/target` to `.gitignore`. No grammar-rule changes.
> **Rebase policy:** binding-only diff, rebased onto upstream when it moves;
> retired if upstream ships an equivalent 0.25 Rust binding.
> **License:** upstream declares MIT (package.json/tree-sitter.json) but shipped no LICENSE file; canonical MIT text added with upstream attribution.
> **Upstream PR:** pending (link will be added here once opened).

JSP (JavaServer Pages) grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

## Features

- JSP directives (`<%@ ... %>`)
- Declarations (`<%! ... %>`)
- Scriptlets (`<% ... %>`)
- Expressions (`<%= ... %>`)
- Comments (`<%-- ... --%>`)
- Expression Language (`${...}` and `#{...}`)
- Language injection queries for Java code blocks and HTML content

## Usage

### Swift (SPM)

Add the package as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/karlvr/tree-sitter-jsp", from: "0.1.0"),
]
```

Then add it to your target's dependencies:

```swift
.product(name: "TreeSitterJSP", package: "tree-sitter-jsp"),
```

Use the parser:

```swift
import TreeSitterJSP
import SwiftTreeSitter

let language = Language(tree_sitter_jsp())
```

### Node.js

```sh
npm install tree-sitter tree-sitter-jsp
```

```javascript
const Parser = require("tree-sitter");
const JSP = require("tree-sitter-jsp");

const parser = new Parser();
parser.setLanguage(JSP);

const tree = parser.parse("<%= request.getParameter(\"name\") %>");
console.log(tree.rootNode.toString());
```

## Developing

### Building

```sh
npm install
npm run build
```

### Testing

```sh
npm test
```

## References

- [JSP Specification](https://jakarta.ee/specifications/pages/)
- [Expression Language Specification](https://jakarta.ee/specifications/expression-language/)

## License

MIT

## Maintenance & support

This grammar is a **fork maintained for our own use, provided as-is, with no support and no SLA.**
We are **not responsible for its ongoing maintenance.** Issues may go unanswered; pull requests
are welcome but are not guaranteed to be reviewed or merged. The upstream project (see the
provenance header above) is the canonical source — please prefer contributing fixes there.
