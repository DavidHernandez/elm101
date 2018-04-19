module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "The Elm Architecture" ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/3.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/5.elm" ]
                [ text "Next" ]
            ]
        ]
