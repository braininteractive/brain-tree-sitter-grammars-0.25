[
  "machine"
] @keyword

[
  "include"
  "import"
] @include

[
  "="
  ":="
  ","
  "|"
  "&"
  "-"
  "--"
  "."
  "!"
  "^"
] @operator

[
  "*"
  "**"
  "?"
  "+"
] @repeat

[
  ":"
  ";"
] @punctuation.delimiter

[
  "{"
  "}"
  "/"
  "["
  "]"
] @punctuation.bracket

(limits ["{" "}"] @repeat)
(limits "," @punctuation.delimiter)

;;
;; Named words
;; ===========
(label
  (word) @label)

(machine_decl
  name: (word) @type)

(machine_def
  name: (word) @type)

(machine_inst
  name: (word) @type)

(include_spec
  machine: (word) @type)

;;
;; Literals
;; ========
[
  (uint)
  (hex)
] @number

[
  (hex_char)
  (literal)
] @character

(string) @string

(regex) @string.regex

[
  (ctrl_code)
  (quote)
  (escape)
] @string.escape

;;
;; Built-ins
;; =========
(any) @constant.macro

((word) @constant.builtin
 (#any-of? @constant.builtin
    "any"
    "ascii"
    "extend"
    "alpha"
    "digit"
    "alnum"
    "lower"
    "upper"
    "cntrl"
    "graph"
    "print"
    "punct"
    "space"
    "xdigit"
    "null"
    "zlen"
    "empty"))

(comment) @comment
