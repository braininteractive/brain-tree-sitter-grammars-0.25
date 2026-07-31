const json = require("tree-sitter-json/grammar");

module.exports = grammar(json, {
  name: "jsonc",

  extras: ($, original) => [...original, $.comment],

  rules: {
    document: ($, original) => optional(original),

    // Trailing commas are valid JSONC (tsconfig.json, VS Code settings,
    // etc. use them pervasively) — upstream only added comments.
    object: ($) =>
      seq("{", optional(seq(commaSep1($.pair), optional(","))), "}"),

    array: ($) =>
      seq("[", optional(seq(commaSep1($._value), optional(","))), "]"),

    comment: ($) =>
      token(
        choice(seq("//", /.*/), seq("/*", /[^*]*\*+([^/*][^*]*\*+)*/, "/"))
      ),
  },
});

function commaSep1(rule) {
  return seq(rule, repeat(seq(",", rule)));
}
