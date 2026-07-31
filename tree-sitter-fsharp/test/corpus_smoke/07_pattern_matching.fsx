let describe value =
    match value with
    | 0 -> "zero"
    | n when n < 0 -> "negative"
    | 1 | 2 | 3 -> "small"
    | _ -> "large"

let (|Even|Odd|) n =
    if n % 2 = 0 then Even else Odd

let parity n =
    match n with
    | Even -> "even"
    | Odd -> "odd"

let tuples =
    match (1, "a") with
    | (1, s) -> s
    | (_, _) -> "other"
