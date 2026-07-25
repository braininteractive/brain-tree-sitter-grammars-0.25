/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

// Tree-sitter grammar for NEON (Nette Object Notation).
// NEON is an indentation-sensitive configuration format used by the Nette
// framework. Indentation (INDENT / DEDENT / NEWLINE) is produced by the
// external scanner in src/scanner.c.

module.exports = grammar({
  name: "neon",

  externals: ($) => [$._newline, $._indent, $._dedent],

  // Keyword extraction: keywords (true/null/…) match only as whole words, so
  // `nulls`, `trueValue`, etc. stay identifiers instead of keyword + leftover.
  word: ($) => $.identifier,

  // Whitespace + comments between tokens. Newlines are normally handled by the
  // external scanner (it has priority wherever NEWLINE/INDENT/DEDENT are valid,
  // i.e. block context). Inside flow context — () [] {} — those tokens are not
  // valid, so the scanner is not consulted and a stray newline falls through to
  // this extra. That is what lets entities / flow collections span lines.
  extras: ($) => [/[ \t\r\n]+/, $.comment],

  // A newline after the last pair/item is ambiguous: continue the block, or
  // let the document's trailing-newline rule consume it. GLR resolves it.
  conflicts: ($) => [
    [$.block_mapping],
    [$.block_sequence],
    // After `- key:` an INDENT is ambiguous: the pair's own indented value, or
    // the next pair of a compact mapping. GLR explores both.
    [$.block_mapping_pair],
  ],

  rules: {
    // Tolerate blank / comment-only lines before and after the content.
    document: ($) =>
      optional(seq(repeat($._newline), $._block_node, repeat($._newline))),

    comment: ($) => token(seq("#", /[^\n]*/)),

    // ---------------------------------------------------------------------
    // Block-level (indentation-based) structures
    // ---------------------------------------------------------------------
    _block_node: ($) =>
      choice($.block_sequence, $.block_mapping, $._flow_node),

    block_mapping: ($) =>
      seq(
        $.block_mapping_pair,
        // repeat1: a comment on its own line yields a line break before AND
        // after it, so siblings may be separated by more than one newline.
        repeat(seq(repeat1($._newline), $.block_mapping_pair)),
      ),

    // NEON accepts both `:` and `=` as the key/value separator.
    block_mapping_pair: ($) =>
      seq(
        field("key", $._key),
        choice(":", "="),
        optional(field("value", $._block_value)),
      ),

    block_sequence: ($) =>
      seq(
        $.block_sequence_item,
        repeat(seq(repeat1($._newline), $.block_sequence_item)),
      ),

    block_sequence_item: ($) =>
      seq(
        "-",
        optional(
          field(
            "value",
            choice(
              $._block_value,
              // Compact mapping: `- key: value` with further pairs aligned on
              // the following lines (a mapping started on the dash line).
              alias($._compact_mapping, $.block_mapping),
            ),
          ),
        ),
      ),

    // First pair sits on the dash line; the rest arrive after an INDENT.
    _compact_mapping: ($) =>
      seq(
        $.block_mapping_pair,
        optional(
          seq(
            $._indent,
            $.block_mapping_pair,
            repeat(seq(repeat1($._newline), $.block_mapping_pair)),
            $._dedent,
          ),
        ),
      ),

    // A value is either inline (on the same line) or an indented block on the
    // following lines.
    _block_value: ($) => choice($._flow_node, $._indented_block),

    _indented_block: ($) => seq($._indent, $._block_node, $._dedent),

    // ---------------------------------------------------------------------
    // Flow (inline) structures
    // ---------------------------------------------------------------------
    _flow_node: ($) =>
      choice($.flow_mapping, $.flow_sequence, $.entity, $._scalar),

    flow_sequence: ($) =>
      seq(
        "[",
        optional(seq($._flow_item, repeat(seq(",", $._flow_item)), optional(","))),
        "]",
      ),

    flow_mapping: ($) =>
      seq(
        "{",
        optional(seq($._flow_item, repeat(seq(",", $._flow_item)), optional(","))),
        "}",
      ),

    // An inline item may be a plain value or a key: value pair. Modelled as a
    // single sequence to avoid a key/value parse conflict.
    _flow_item: ($) =>
      seq(
        field("key", $._flow_node),
        optional(seq(choice(":", "="), optional(field("value", $._flow_node)))),
      ),

    // Service / entity definition, e.g. Foo\Bar(arg, key: value).
    // Entities may be chained with whitespace: Column(type: int) Field(id: 1)
    entity: ($) =>
      prec.left(2, seq($._entity_call, repeat($._entity_call))),

    // Arguments separate on `,` OR on a line break (comma-less multiline
    // entities are valid NEON). Naming $._newline as a separator makes the
    // external scanner get consulted inside the parens at separator
    // positions, where it emits NEWLINE for the line break that the
    // whitespace extra would otherwise swallow (which used to fuse
    // adjacent args into one plain_scalar).
    _entity_call: ($) =>
      seq(
        field("name", choice($.identifier, $.string)),
        "(",
        optional(
          seq(
            $._flow_item,
            repeat(seq(choice(",", $._newline), $._flow_item)),
            optional(choice(",", $._newline)),
          ),
        ),
        ")",
      ),

    // ---------------------------------------------------------------------
    // Scalars
    // ---------------------------------------------------------------------
    _key: ($) => choice($.string, $.number, $.boolean, $.null, $.identifier),

    _scalar: ($) =>
      choice(
        $.string,
        $.datetime,
        $.number,
        $.boolean,
        $.null,
        $.reference,
        $.plain_scalar,
      ),

    // A bare value, possibly interpolating %parameters%, e.g. %tempDir%/cache.
    // Adjacent identifier / parameter tokens concatenate into one scalar.
    plain_scalar: ($) =>
      prec.right(repeat1(choice($.parameter, $.identifier))),

    string: ($) =>
      choice(
        $._triple_string,
        seq('"', repeat(choice(/[^"\\]/, /\\./)), '"'),
        seq("'", repeat(choice(/[^']/, "''")), "'"),
      ),

    // Triple-quoted multiline string: """ … """ or ''' … ''' spanning lines.
    // A single token so the external scanner does not interrupt mid-string.
    _triple_string: ($) =>
      token(
        prec(
          1,
          choice(
            seq('"""', /([^"]|"[^"]|""[^"])*/, '"""'),
            seq("'''", /([^']|'[^']|''[^'])*/, "'''"),
          ),
        ),
      ),

    // Date / datetime literal, e.g. 2016-06-03 or 2016-06-03 19:49:00 +0200.
    // Higher precedence than `number` so the leading year is not split off.
    datetime: ($) =>
      token(
        prec(
          3,
          /\d{4}-\d{1,2}-\d{1,2}([ T]\d{1,2}:\d{2}(:\d{2})?(\.\d+)?( ?[-+]\d{2}:?\d{2}|Z)?)?/,
        ),
      ),

    number: ($) =>
      token(
        prec(
          2,
          choice(
            /[+-]?\d+(\.\d+)?([eE][+-]?\d+)?/,
            /0[xX][0-9a-fA-F]+/,
            /0[oO][0-7]+/,
            /0[bB][01]+/,
          ),
        ),
      ),

    boolean: ($) =>
      choice(
        "true", "false", "True", "False", "TRUE", "FALSE",
        "yes", "no", "Yes", "No", "YES", "NO",
        "on", "off", "On", "Off", "ON", "OFF",
      ),

    null: ($) => choice("null", "Null", "NULL", "~"),

    // @serviceName references
    reference: ($) => token(seq("@", /[^\s,:=\[\]{}()'"#]+/)),

    // %parameter% expansion. Excludes '%' internally so it ends at the closing
    // delimiter; concatenation with surrounding text is handled by plain_scalar.
    parameter: ($) => token(seq("%", /[^\s%]*/, "%")),

    // Bare (unquoted) string / key. NEON rules encoded in the token:
    //   * may not begin with a structural char, '@', '%', or a list dash
    //   * MAY contain internal spaces (e.g. `name: My Application`)
    //   * a ':' is part of the literal only when followed by a non-space
    //     (so `Foo::bar` and `host:port` stay whole, but `key: value` splits)
    //   * excludes '%' so %parameters% split out as their own tokens
    // No lookahead in the token regex, so the trailing char is consumed by
    // each alternative to guarantee the token never ends on a space or colon.
    identifier: ($) =>
      token(
        prec(
          0,
          /[^\s#,:=\[\]{}()'"@%\-]([^\s,:=\[\]{}()'"#%]|[ \t]+[^\s,:=\[\]{}()'"#%]|:+[^\s,:=\[\]{}()'"#%])*/,
        ),
      ),
  },
});
