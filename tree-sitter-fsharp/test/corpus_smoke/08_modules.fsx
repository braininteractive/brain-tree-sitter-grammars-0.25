module Geometry =
    let pi = 3.14159

    module Circles =
        let area r = pi * r * r

open Geometry

let a = Circles.area 2.0

[<AutoOpen>]
module Helpers =
    let double x = x * 2
