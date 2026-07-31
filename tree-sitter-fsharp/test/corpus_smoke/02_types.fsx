type Point = { X: float; Y: float }

type Shape =
    | Circle of radius: float
    | Rectangle of width: float * height: float

type Counter() =
    let mutable count = 0
    member _.Increment() =
        count <- count + 1
        count
    member _.Value = count

let area shape =
    match shape with
    | Circle r -> System.Math.PI * r * r
    | Rectangle (w, h) -> w * h
