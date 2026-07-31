port module Bridge exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


port sendMessage : Encode.Value -> Cmd msg


port receiveMessage : (Encode.Value -> msg) -> Sub msg


userDecoder : Decoder { name : String }
userDecoder =
    Decode.map (\n -> { name = n })
        (Decode.field "name" Decode.string)
