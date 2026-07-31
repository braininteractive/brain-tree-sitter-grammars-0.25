module Funcs exposing (..)


add : Int -> Int -> Int
add a b =
    a + b


increment : Int -> Int
increment =
    add 1


applyTwice : (a -> a) -> a -> a
applyTwice f x =
    f (f x)


result : Int
result =
    [ 1, 2, 3 ]
        |> List.map ((*) 2)
        |> List.filter (\n -> n > 2)
        |> List.foldl (+) 0
