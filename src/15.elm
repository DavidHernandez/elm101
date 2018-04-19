module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import List


type alias Model =
    { posts : WebData String PostList
    , activePage : Page
    }


type WebData error data
    = NotAsked
    | Error error
    | Success data


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
    { posts = NotAsked
    , activePage = BlogList
    }


init : ( Model, Cmd Msg )
init =
    ( model
    , fetchPosts
    )


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
    case model.posts of
        NotAsked ->
            div [] [ text "Loading..." ]

        Success posts ->
            case model.activePage of
                BlogList ->
                    viewPostList posts

                Blog postId ->
                    let
                        post =
                            List.filter (\post -> post.id == postId) posts
                                |> List.head
                    in
                        case post of
                            Just aPost ->
                                viewBlog aPost

                            Nothing ->
                                view404

        Error error ->
            div [] [ text error ]


fetchPosts : Cmd Msg
fetchPosts =
    let
        url =
            "http://drelm.local/jsonapi/blog"
    in
        Http.send FetchPosts (httpGet url postListDecoder)


postListDecoder : Decoder PostList
postListDecoder =
    Decode.at [ "data" ] (list postDecoder)


postDecoder : Decoder Post
postDecoder =
    Decode.at [ "attributes" ]
        (decode Post
            |> required "id" int
            |> required "title" string
            |> required "body" string
        )


type Msg
    = NavigateTo Page
    | FetchPosts (Result Http.Error PostList)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo page ->
            ( { model | activePage = page }, Cmd.none )

        FetchPosts (Ok posts) ->
            ( { model | posts = Success posts }, Cmd.none )

        FetchPosts (Err err) ->
            let
                _ =
                    Debug.log "Error" err
            in
                ( { model | posts = Error "error" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    program
        { init = init
        , view = mainView
        , update = update
        , subscriptions = subscriptions
        }


mainView model =
    div
        []
        [ view model
        , div
            []
            [ a
                [ href "http://localhost:8000/src/14.elm" ]
                [ text "Prev" ]
            ]
        , div
            []
            [ a
                [ href "http://localhost:8000/src/16.elm" ]
                [ text "Next" ]
            ]
        ]


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
