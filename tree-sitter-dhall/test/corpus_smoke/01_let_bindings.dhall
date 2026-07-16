-- Chained let bindings with a final expression.
let name = "world"

let count = 42

let enabled = True

let shadowed = 1

let shadowed = shadowed + 1

in  { name, count, enabled, shadowed }
