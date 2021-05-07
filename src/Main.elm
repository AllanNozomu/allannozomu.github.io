module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, img, text)
import Html.Attributes exposing (class, href, id, src, title)
import Icons



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ leftMenu model
        , containerBody model
        ]


leftMenu : Model -> Html Msg
leftMenu model =
    div [ id "leftMenu" ]
        [ div [ id "upperMenu" ]
            [ div [ class "item", title "Home" ] [ Icons.home ]
            , div [ class "item", title "Projects" ] [ Icons.code ]
            , div [ class "item", title "Blog" ] [ Icons.penTool ]
            ]
        , div [ id "lowerMenu" ]
            [ div [ class "item", title "Github" ]
                [ a [ href "https://github.com/allannozomu" ] [ Icons.github ]
                ]
            , div [ class "item", title "Linkedin" ]
                [ a [ href "https://www.linkedin.com/in/allan-nozomu/" ] [ Icons.linkedin ]
                ]
            ]
        ]


containerBody : Model -> Html Msg
containerBody model =
    div [ id "containerBody" ]
        [ h1 [] [ text "Hello World" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
