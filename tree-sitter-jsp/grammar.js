/**
 * @file JSP (JavaServer Pages) grammar for tree-sitter
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: 'jsp',

  extras: _ => [],

  externals: $ => [
    $._comment_content,
  ],

  rules: {
    template: $ => repeat(choice(
      $.comment,
      $.directive,
      $.declaration,
      $.expression,
      $.scriptlet,
      $.el_expression,
      $.content,
    )),

    // <%-- JSP comment --%>
    comment: $ => seq(
      '<%--',
      optional($._comment_content),
      '--%>',
    ),

    // <%@ page/taglib/include attributes %>
    directive: $ => seq(
      '<%@',
      optional($.directive_attribute),
      '%>',
    ),

    directive_attribute: _ => repeat1(choice(
      /[^%]+/,
      /%[^>]/,
    )),

    // <%! variable and method declarations %>
    declaration: $ => seq(
      '<%!',
      optional($.code),
      '%>',
    ),

    // <%= expression to output %>
    expression: $ => seq(
      '<%=',
      optional($.code),
      '%>',
    ),

    // <% scriptlet code %>
    scriptlet: $ => seq(
      '<%',
      optional($.code),
      '%>',
    ),

    // Java code inside <% %>, <%= %>, and <%! %> blocks.
    // Parsed as opaque text here; Java highlighting is provided
    // via language injection (see queries/injections.scm).
    code: _ => repeat1(choice(
      /[^%]+/,
      /%[^>]/,
    )),

    // ${expr} and #{expr} — Expression Language
    el_expression: $ => seq(
      choice('${', '#{'),
      optional($.el_content),
      '}',
    ),

    el_content: _ => repeat1(choice(
      /[^}'\\]+/,
      /\\./,
      seq("'", /[^'\\]*/, optional(seq('\\', /./, /[^'\\]*/)), "'"),
    )),

    content: _ => prec.right(repeat1(choice(
      /[^<$#]+/,
      /\$[^{]/,
      /#[^{]/,
      '$',
      '#',
      '<',
    ))),
  },
});
