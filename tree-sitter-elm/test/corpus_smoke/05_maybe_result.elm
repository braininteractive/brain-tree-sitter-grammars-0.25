module Safety exposing (..)


safeDivide : Float -> Float -> Result String Float
safeDivide numerator denominator =
    if denominator == 0 then
        Err "division by zero"

    else
        Ok (numerator / denominator)


firstPositive : List Int -> Maybe Int
firstPositive numbers =
    numbers
        |> List.filter (\n -> n > 0)
        |> List.head


display : Maybe Int -> String
display maybeN =
    maybeN
        |> Maybe.map String.fromInt
        |> Maybe.withDefault "none"
