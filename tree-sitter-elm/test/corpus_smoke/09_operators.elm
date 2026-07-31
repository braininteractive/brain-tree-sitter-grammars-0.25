module Ops exposing (..)


calc : Int
calc =
    (1 + 2) * 3 // 2 - modBy 3 10


concat : String
concat =
    "a" ++ "b" ++ String.repeat 2 "c"


logic : Bool
logic =
    (True && False) || not (1 == 2) && (3 /= 4) && (1 < 2) && (2 >= 1)


cons : List Int
cons =
    1 :: 2 :: [ 3 ]
