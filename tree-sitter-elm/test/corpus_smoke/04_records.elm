module Records exposing (..)


type alias Point =
    { x : Float, y : Float }


origin : Point
origin =
    { x = 0, y = 0 }


moveRight : Float -> Point -> Point
moveRight dx point =
    { point | x = point.x + dx }


getX : { a | x : Float } -> Float
getX record =
    record.x
