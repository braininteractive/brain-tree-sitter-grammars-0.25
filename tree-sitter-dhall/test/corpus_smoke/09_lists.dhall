-- List literals, List type, and list builtins.
let numbers
    : List Natural
    = [ 1, 2, 3, 4, 5 ]

let words = [ "one", "two", "three" ]

let nested
    : List (List Natural)
    = [ [ 1, 2 ], [ 3, 4 ] ]

let empty = [] : List Bool

let total = List/length Natural numbers

let doubled = List/map Natural Natural (\(n : Natural) -> n * 2) numbers

in  { numbers, words, nested, empty, total, doubled }
