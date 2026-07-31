module Types exposing (..)


type alias User =
    { id : Int
    , name : String
    , email : Maybe String
    }


type Status
    = Active
    | Suspended String
    | Deleted


describe : Status -> String
describe status =
    case status of
        Active ->
            "active"

        Suspended reason ->
            "suspended: " ++ reason

        Deleted ->
            "gone"
