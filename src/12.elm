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
    { id : PostId
    , title : String
    , body : String
    }


type alias PostId =
    Int


type Page
    = BlogList
    | Blog PostId


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
        (List.map viewPostTeaser posts
            ++ [ div
                    [ onClick <| NavigateTo <| Blog 404 ]
                    [ text "Error link" ]
               ]
        )


viewPostTeaser : Post -> Html Msg
viewPostTeaser post =
    div
        [ onClick <| NavigateTo <| Blog post.id ]
        [ text post.title ]


viewBlog : Post -> Html Msg
viewBlog post =
    div
        []
        [ h2
            []
            [ text post.title ]
        , div
            []
            [ text post.body ]
        , a
            [ onClick <| NavigateTo BlogList ]
            [ text "Go back" ]
        ]


view404 : Html Msg
view404 =
    div
        []
        [ div
            []
            [ h2 [] [ text "Page not found" ] ]
        , a
            [ onClick <| NavigateTo BlogList ]
            [ text "Go back" ]
        ]


view : Model -> Html Msg
view model =
    case model.activePage of
        BlogList ->
            viewPostList model.posts

        Blog postId ->
            let
                post =
                    List.filter (\post -> post.id == postId) model.posts
                        |> List.head
            in
                case post of
                    Just aPost ->
                        viewBlog aPost

                    Nothing ->
                        view404


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
                [ href "http://localhost:8000/src/11.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/13.elm" ]
                [ text "Next" ]
            ]
        ]


main =
    beginnerProgram
        { model = model
        , view = mainView
        , update = update
        }
