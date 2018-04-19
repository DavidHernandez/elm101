module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    div
        []
        [ h2
            []
            [ text "Time to build our app:" ]
        , div
            []
            [ text "elm make src/15.elm --output=index.html" ]
        , div
            []
            [ a
                [ href "http://drelm.local/index.html" ]
                [ text "View compiled version" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/16.elm" ]
                [ text "Prev" ]
            ]
        ]
