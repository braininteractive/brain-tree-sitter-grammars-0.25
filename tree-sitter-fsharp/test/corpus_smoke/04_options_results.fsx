let tryDivide a b =
    if b = 0 then None
    else Some (a / b)

let safeParse (s: string) : Result<int, string> =
    match System.Int32.TryParse s with
    | true, value -> Ok value
    | false, _ -> Error (sprintf "invalid: %s" s)

let display =
    match tryDivide 10 2 with
    | Some v -> string v
    | None -> "undefined"
