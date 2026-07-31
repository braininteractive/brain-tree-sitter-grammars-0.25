module Update exposing (..)


type Msg
    = Increment
    | Decrement
    | SetValue Int


type alias Model =
    { count : Int }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        SetValue n ->
            { model | count = n }
