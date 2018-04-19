module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "Elm 101" ]
        , h3
            []
            [ text "David Hernandez" ]
        , div
            []
            [ a
                [ href "https://github.com/DavidHernandez/elm101" ]
                [ text "https://github.com/DavidHernandez/elm101" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/2.elm" ]
                [ text "Next" ]
            ]
        ]
