module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import List


type alias Model =
    { posts : PostList
    , activePage : Page
    }


type alias Post =
    { id : PostId
    , title : String
    , body : String
    }


type alias PostId =
    Int


type alias PostList =
    List Post


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


postListDecoder : Decoder PostList
postListDecoder =
    Decode.list postDecoder


postDecoder : Decoder Post
postDecoder =
    decode Post
        |> required "id" int
        |> required "title" string
        |> required "body" string


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
                [ href "http://localhost:8000/src/13.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/15.elm" ]
                [ text "Next" ]
            ]
        ]


main =
    beginnerProgram
        { model = model
        , view = mainView
        , update = update
        }


httpGet : String -> Decoder value -> Http.Request value
httpGet url decoder =
    Http.request
        { method = "GET"
        , headers =
            [ Http.header "Access-Control-Allow-Origin" "*"
            , Http.header "Content-type" "application/vnd.api+json"
            , Http.header "Accept" "application/vnd.api+json"
            , Http.header "Origin" "http://drelm.local"
            , Http.header "Access-Control-Allow-Methods" "GET"
            , Http.header "Access-Control-Request-Headers" "X-Custom-Header"
            ]
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }
