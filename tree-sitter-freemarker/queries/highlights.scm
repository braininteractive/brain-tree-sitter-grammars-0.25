; Comments
(comment) @comment

; Interpolation delimiters
(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

; Interpolation expression content
(expression) @variable

; Directive delimiters - angle brackets
(angle_directive
  "<#" @tag.delimiter)
(angle_directive
  "</#" @tag.delimiter)
(angle_directive
  ">" @tag.delimiter)

; Directive delimiters - square brackets
(square_directive
  "[#" @tag.delimiter)
(square_directive
  "[/#" @tag.delimiter)
(square_directive
  "]" @tag.delimiter)

; User directive delimiters - angle brackets
(angle_user_directive
  "<@" @tag.delimiter)
(angle_user_directive
  "</@" @tag.delimiter)
(angle_user_directive
  ">" @tag.delimiter)
(angle_user_directive
  "/>" @tag.delimiter)

; User directive delimiters - square brackets
(square_user_directive
  "[@" @tag.delimiter)
(square_user_directive
  "[/@" @tag.delimiter)
(square_user_directive
  "]" @tag.delimiter)
(square_user_directive
  "/]" @tag.delimiter)

; Directive names (keywords)
(directive_name) @keyword

; Directive content
(directive_content) @none

; Plain content
(content) @none
