-- Operators: ++ (text append), # (list append),
-- /\ and its unicode form (record merge), // and its unicode form (prefer).
let hello = "hello" ++ " " ++ "world"

let joined = [ 1, 2 ] # [ 3, 4 ] # [ 5 ]

let deepMerged = { a = 1, nested = { x = 1 } } /\ { b = 2, nested = { y = 2 } }

let unicodeMerged = { a = 1 } ∧ { b = 2 }

let preferred = { a = 1, b = 2 } // { b = 3, c = 4 }

let unicodePreferred = { a = 1 } ⫽ { a = 2 }

let combinedTypes = { a : Natural } //\\ { b : Text }

in  { hello
    , joined
    , deepMerged
    , unicodeMerged
    , preferred
    , unicodePreferred
    , logic = True && False || True
    }
