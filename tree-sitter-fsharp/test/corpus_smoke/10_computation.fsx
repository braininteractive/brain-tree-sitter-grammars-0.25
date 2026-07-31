type MaybeBuilder() =
    member _.Bind(x, f) =
        match x with
        | Some v -> f v
        | None -> None
    member _.Return(x) = Some x

let maybe = MaybeBuilder()

let sumOptions a b = maybe {
    let! x = a
    let! y = b
    return x + y
}

let r = sumOptions (Some 1) (Some 2)
