module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List


type alias Model =
    { posts : List Post
    , activePage : Page
    }


type alias Post =
    { id : Int
    , title : String
    , body : String
    }


type Page
    = BlogList
    | Blog


model : Model
model =
    { posts =
        [ Post 1 "First title" "Body of first blog"
        , Post 2 "Second blog post" "Body of third blog post"
        ]
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
        [ onClick <| NavigateTo Blog ]
        [ text post.title ]


viewBlog : Html Msg
viewBlog =
    div
        [ onClick <| NavigateTo BlogList ]
        [ text "This will be a blog post" ]


view : Model -> Html Msg
view model =
    case model.activePage of
        BlogList ->
            viewPostList model.posts

        Blog ->
            viewBlog


type Msg
    = NavigateTo Page


update : Msg -> Model -> Model
update msg model =
    case msg of
        NavigateTo page ->
            { model | activePage = page }


mainView model =
    div
        []
        [ view model
        , div
            []
            [ a
                [ href "http://localhost:8000/src/8.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/10.elm" ]
                [ text "Next" ]
            ]
        ]


main =
    beginnerProgram
        { model = model
        , view = mainView
        , update = update
        }
