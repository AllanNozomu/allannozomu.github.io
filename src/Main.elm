module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, id, src)
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
            [ div [ class "item" ] [ Icons.home ]
            , div [ class "item" ] [ Icons.code ]
            , div [ class "item" ] [ Icons.tool ]
            , div [ class "item" ] [ Icons.penTool ]
            ]
        ,div [ id "lowerMenu" ]
            [ div [ class "item" ] [ Icons.github ]
            , div [ class "item" ] [ Icons.linkedin ]
            ]
        ]


containerBody : Model -> Html Msg
containerBody model =
    div [ id "containerBody" ]
        [ h1 [] [ text "Hello World" ]
        ]


footer : Model -> Html Msg
footer model =
    div [ id "footer" ]
        [ text "Made by Allannozomu"
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
