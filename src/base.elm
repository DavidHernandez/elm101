module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "The basics" ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/2.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/4.elm" ]
                [ text "Next" ]
            ]
        ]
