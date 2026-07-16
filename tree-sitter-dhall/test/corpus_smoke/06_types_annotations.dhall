-- Type annotations on bindings, expressions, and empty containers.
let n
    : Natural
    = 5

let i
    : Integer
    = -3

let d
    : Double
    = 3.14

let annotatedInline = 1 : Natural

let emptyList = [] : List Natural

let Pair = \(a : Type) -> { first : a, second : a }

let origin
    : Pair Double
    = { first = 0.0, second = 0.0 }

in  { n, i, d, annotatedInline, emptyList, origin }
