let add a b = a + b
let increment = add 1
let apply f x = f x

let rec factorial n =
    if n <= 1 then 1
    else n * factorial (n - 1)

let pipeline =
    [ 1; 2; 3; 4; 5 ]
    |> List.filter (fun n -> n % 2 = 0)
    |> List.map ((*) 10)
    |> List.sum
