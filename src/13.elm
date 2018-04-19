module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "Connecting with the backend" ]
        , div
            []
            [ text "elm package install NoRedInk/elm-decode-pipeline" ]
        , div
            []
            [ text "elm package install elm-lang/http" ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/12.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/14.elm" ]
                [ text "Next" ]
            ]
        ]
