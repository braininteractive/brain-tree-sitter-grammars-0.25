-- Text interpolation with ${}, escapes, and single-quote (multiline) text.
let name = "world"

let count = 3

let greeting = "hello ${name}"

let detail = "there are ${Natural/show count} items in ${name}"

let escaped = "literal \${not interpolated} and a quote: \""

let block =
      ''
      multiline text
      with ${name} interpolated
      and ''${escaped} braces
      ''

in  { greeting, detail, escaped, block }
