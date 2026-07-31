module Lets exposing (..)


area : Float -> Float -> Float
area width height =
    let
        base =
            width * height

        adjustment =
            if base > 100 then
                0.9

            else
                1.0

        ( scaled, label ) =
            ( base * adjustment, "area" )
    in
    scaled
