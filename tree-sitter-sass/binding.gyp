{
  "bindings": {
    "node": {
      "targets": [
        {
          "target_name": "tree_sitter_sass_binding",
          "include_dirs": [
            "<!(node -e \"require('nan')\")",
            "src"
          ],
          "sources": [
            "bindings/node/binding.cc",
            "src/parser.c",
            "src/scanner.c"
          ],
          "cflags_c": [
            "-std=c11"
          ]
        }
      ]
    }
  }
}
