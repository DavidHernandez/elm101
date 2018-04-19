module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "Did you notice the bottom right corner?" ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/15.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/17.elm" ]
                [ text "Next" ]
            ]
        ]
