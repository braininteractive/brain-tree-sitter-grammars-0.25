[<Measure>] type m
[<Measure>] type s

let distance = 100.0<m>
let time = 9.58<s>
let speed = distance / time

type IShape =
    abstract member Area: float

type Square(side: float) =
    interface IShape with
        member _.Area = side * side
