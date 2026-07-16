; Comments
(comment) @comment

; Scalars
(string) @string
(datetime) @number
(number) @number
(boolean) @boolean
(null) @constant.builtin
(reference) @variable.special
(parameter) @variable.special
(plain_scalar (identifier) @string)

; Mapping keys
(block_mapping_pair key: (identifier) @property)
(block_mapping_pair key: (string) @property)
(block_mapping_pair key: (number) @property)
(flow_mapping key: (plain_scalar) @property)
(flow_mapping key: (string) @property)

; Entity / service definitions
(entity name: (identifier) @function)
(entity name: (string) @function)
(entity key: (plain_scalar) @property)
(entity key: (string) @property)

; Punctuation
["[" "]" "{" "}" "(" ")"] @punctuation.bracket
[":" "=" ","] @punctuation.delimiter
"-" @punctuation.special
