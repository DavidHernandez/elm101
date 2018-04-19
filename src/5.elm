module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    String


model : Model
model =
    "Hello world"


view : Model -> Html Msg
view model =
    text model


type Msg
    = NoOp


mainView model =
    div
        []
        [ view model
        , div
            []
            [ a
                [ href "http://localhost:8000/src/4.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/6.elm" ]
                [ text "Next" ]
            ]
        ]


main =
    mainView model
