/**
 * @file Freemarker Template grammar for tree-sitter
 * @author Adapted from tree-sitter-embedded-template
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: 'freemarker',

  extras: _ => [],

  rules: {
    template: $ => repeat(choice(
      $.directive,
      $.interpolation,
      $.comment,
      $.content,
    )),

    // Content: anything that's not a directive, interpolation, or comment
    content: _ => prec.right(repeat1(choice(
      /[^<\[\$]+/,
      '<',
      '[',
      '$',
    ))),

    // Interpolation: ${...}
    interpolation: $ => seq(
      '${',
      optional($.expression),
      '}',
    ),

    expression: _ => /[^}]+/,

    // Comments: <#-- ... --> or [#-- ... --]
    comment: $ => choice(
      seq('<#--', optional($.comment_content), '-->'),
      seq('[#--', optional($.comment_content), '--]'),
    ),

    // Match the whole comment body in one token, allowing interior hyphens
    // (e.g. "LICENSE-2.0"). A hyphen is only significant when it begins the
    // closing delimiter `-->` or `--]`; everything else — including single and
    // double hyphens followed by other characters — is comment content.
    comment_content: _ => /([^-]|-[^-]|--+[^>\]-])+/,

    // Directives: <#keyword ...> or [#keyword ...]
    directive: $ => choice(
      $.angle_directive,
      $.square_directive,
      $.angle_user_directive,
      $.square_user_directive,
    ),

    // Angle bracket directives: <#keyword> and </#keyword>
    angle_directive: $ => seq(
      choice('<#', '</#'),
      $.directive_name,
      optional($.directive_content),
      '>',
    ),

    // Square bracket directives: [#keyword] and [/#keyword]
    square_directive: $ => seq(
      choice('[#', '[/#'),
      $.directive_name,
      optional($.directive_content),
      ']',
    ),

    // User directives with @: <@name> and </@name>
    angle_user_directive: $ => seq(
      choice('<@', '</@'),
      $.directive_name,
      optional($.directive_content),
      choice('>', '/>'),
    ),

    // User directives with @: [@name] and [/@name]
    square_user_directive: $ => seq(
      choice('[@', '[/@'),
      $.directive_name,
      optional($.directive_content),
      choice(']', '/]'),
    ),

    directive_name: _ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    directive_content: _ => /[^>\]\/>\/\]]+/,
  },
});
