let list = [ 1; 2; 3 ]
let array = [| "a"; "b" |]
let sequence = seq { for i in 1 .. 5 -> i * i }
let map = Map.ofList [ "one", 1; "two", 2 ]
let set = Set.ofList [ 1; 1; 2 ]

let comprehension =
    [ for x in 1 .. 3 do
        for y in 1 .. 3 do
          if x <> y then yield x, y ]
