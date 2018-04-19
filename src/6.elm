module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import List


type alias Model =
    { posts : List Post
    , activePage : Page
    }


type alias Post =
    String


type Page
    = BlogList
    | Blog


model : Model
model =
    { posts = [ "First post", "Second post" ]
    , activePage = BlogList
    }


viewPostList : List Post -> Html Msg
viewPostList posts =
    div
        []
        (List.map viewPostTeaser posts)


viewPostTeaser : Post -> Html Msg
viewPostTeaser post =
    div
        []
        [ text post ]


view : Model -> Html Msg
view model =
    viewPostList model.posts


type Msg
    = NoOp


mainView model =
    div
        []
        [ view model
        , div
            []
            [ a
                [ href "http://localhost:8000/src/5.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/7.elm" ]
                [ text "Next" ]
            ]
        ]


main =
    mainView model
