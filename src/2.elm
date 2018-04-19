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
            [ text "npm install -g elm" ]
        , div
            []
            [ text "This give us four shell commands:" ]
        , ul
            []
            [ li
                []
                [ text "elm repl" ]
            , li
                []
                [ text "elm reactor" ]
            , li
                []
                [ text "elm make" ]
            , li
                []
                [ text "elm package" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/1.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/3.elm" ]
                [ text "Next" ]
            ]
        ]
