/**
 * Helper: `rule` separated by `sep`, at least one occurrence.
 */
function sep1(rule, sep) {
  return seq(rule, repeat(seq(sep, rule)));
}

module.exports = grammar({
  name: "ibmhlasm",

  // We use src/scanner.c to handle context sensitive tokens, such as names
  externals: $ => [
    $.name,  // scanner.c checks for a token in column 0
    $.comment, // scanner.c checks for a * in column 0
    $.operands,  // Parsed via scanner.c to handle continuation lines
    $.remark,  // Parsed via scanner.c to handle continuation lines
  ],

  // We need to manually control whitespace since this language cares about newlines
  extras: $ => [
    /[ ]+/
  ],

  // Keyword extraction: MACRO/MEND/AIF/... are only treated as keywords when
  // they match a whole opcode-shaped token (so MACROX stays a plain operation)
  word: $ => $._alphanum_str,

  rules: {
    program: $ => seq(
      choice(
        $._statement,
        $._newline, // Whitespace lines are OK
      ),
      repeat(
        seq(
          $._newline,
        choice(
            $._statement,
            $._newline,
          ),
        ),
      ),
      // A file may end with a trailing newline (fixes the upstream quirk
      // where EOF-after-newline produced a zero-width MISSING node)
      optional($._newline),
    ),

    _newline: $ => /[\s]*\n/,

    // One source line (or, for macro definitions, a block of lines)
    _statement: $ => choice(
      $.comment, // Unlike remarks, comments take up an entire line
      $.macro_comment, // ".*" macro-internal comment lines
      $.macro_definition, // MACRO ... prototype ... MEND
      $.local_declaration, // LCLA/LCLB/LCLC
      $.global_declaration, // GBLA/GBLB/GBLC
      $.set_statement, // &SYM SETA/SETB/SETC expr
      $.aif_statement, // AIF (cond).SEQ
      $.ago_statement, // AGO .SEQ
      $.anop_statement, // .SEQ ANOP
      $.mexit_statement, // MEXIT
      $.mnote_statement, // MNOTE severity,'message'
      $.instruction, // NAME OPCODE OPERANDS REMARK
    ),

    instruction: $ => choice(
      seq(
        // No remark case
        optional($._name_field),
        $.operation,
        optional(
          choice(
            ",",
            $.operands,
          ),
        ),
      ),
      // Remark case: if there's a remark, an operand list is required (or at least a ,)
      seq(
        optional($._name_field),
        $.operation,
        choice(
          ",",
          $.operands,
        ),
        $.remark,
      ),
    ),

    // Model statements inside macro bodies may carry &VAR or .SEQ labels
    _name_field: $ => choice(
      $.name,
      $.variable_symbol,
      $.sequence_symbol,
    ),

    // Opcodes are alphanumeric
    operation: $ => $._alphanum_str,

    _alphanum_str: $ => /[A-Za-z0-9]+/,

    // ------------------------------------------------------------------
    // Macro definitions: MACRO / prototype / body / MEND
    // ------------------------------------------------------------------

    macro_definition: $ => seq(
      $.macro_header,
      $._newline,
      // Comment lines are permitted between MACRO and the prototype
      repeat(seq(choice($.comment, $.macro_comment), $._newline)),
      $.macro_prototype,
      repeat(
        seq(
          $._newline,
          choice(
            $._statement,
            $._newline,
          ),
        ),
      ),
      $._newline,
      $.macro_trailer,
    ),

    macro_header: $ => seq("MACRO", optional($.remark)),

    macro_trailer: $ => seq(
      optional($.sequence_symbol),
      "MEND",
      optional($.remark),
    ),

    // Prototype line: [&label] MACNAME [&P1,&P2,&KW=default,...]
    macro_prototype: $ => seq(
      optional($.variable_symbol),
      alias($._alphanum_str, $.macro_name),
      optional(sep1($.macro_parameter, ",")),
    ),

    // Positional (&P1) or keyword (&KW=default) parameter
    macro_parameter: $ => seq(
      $.variable_symbol,
      optional(seq("=", optional($._parameter_default))),
    ),

    _parameter_default: $ => repeat1(choice(
      $.variable_symbol,
      $.string,
      $._operand_chunk,
      $.paren_group,
    )),

    // ------------------------------------------------------------------
    // Conditional assembly (SET symbols, branching)
    // ------------------------------------------------------------------

    local_declaration: $ => seq(
      optional($.sequence_symbol),
      choice("LCLA", "LCLB", "LCLC"),
      sep1($._declared_symbol, ","),
    ),

    global_declaration: $ => seq(
      optional($.sequence_symbol),
      choice("GBLA", "GBLB", "GBLC"),
      sep1($._declared_symbol, ","),
    ),

    _declared_symbol: $ => seq(
      $.variable_symbol,
      optional(alias($.paren_group, $.subscript)),
    ),

    set_statement: $ => seq(
      $.variable_symbol,
      optional(alias($.paren_group, $.subscript)),
      choice("SETA", "SETB", "SETC"),
      $._ca_operand,
    ),

    aif_statement: $ => seq(
      optional($.sequence_symbol),
      "AIF",
      alias($.paren_group, $.condition),
      $.sequence_symbol,
      optional($.remark),
    ),

    ago_statement: $ => seq(
      optional($.sequence_symbol),
      "AGO",
      optional(alias($.paren_group, $.condition)), // computed AGO
      $.sequence_symbol,
      optional($.remark),
    ),

    anop_statement: $ => seq(
      optional($.sequence_symbol),
      "ANOP",
      optional($.remark),
    ),

    mexit_statement: $ => seq(
      optional($.sequence_symbol),
      "MEXIT",
      optional($.remark),
    ),

    mnote_statement: $ => seq(
      optional($.sequence_symbol),
      "MNOTE",
      optional($._ca_operand),
    ),

    // Flat conditional-assembly operand "soup": variable symbols and quoted
    // strings are surfaced as nodes, everything else stays as chunks.
    _ca_operand: $ => repeat1(choice(
      $.variable_symbol,
      $.string,
      $._operand_chunk,
      $.paren_group,
      ",",
    )),

    // Parenthesized group (logical expressions, subscripts, sublists)
    paren_group: $ => seq(
      "(",
      repeat(choice(
        $.variable_symbol,
        $.string,
        $._paren_chunk,
        $.paren_group,
      )),
      ")",
    ),

    // Quoted string; &VAR references inside are surfaced, '' and && are escapes
    string: $ => seq(
      "'",
      repeat(choice(
        $.variable_symbol,
        "&&",
        /([^'&\n]|'')*[^'&\n]/,
      )),
      "'",
    ),

    // Chunk tokens: opaque runs inside conditional-assembly operands.
    // A trailing quote is allowed so attribute references (T'&X, L'SYM)
    // don't open a string.
    _operand_chunk: $ => /[^()&'\s,]+'?/,
    _paren_chunk: $ => /[^()&'\s]+'?/,

    variable_symbol: $ => /&[A-Za-z$#@_][A-Za-z0-9$#@_]*/,

    sequence_symbol: $ => /\.[A-Za-z$#@_][A-Za-z0-9$#@_]*/,

    macro_comment: $ => /\.\*[^\n]*/,
  }
});
