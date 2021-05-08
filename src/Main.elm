module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, img, p, pre, span, text)
import Html.Attributes exposing (class, href, id, src, target, title)
import Html.Events exposing (onClick)
import Icons
import Task
import Time



---- MODEL ----


type WritingStatus
    = Writing
    | Clearing
    | Pause


type alias Model =
    { currentPosition : Int
    , currentHeader : String
    , nextHeader : String
    , writingStatus : WritingStatus
    }


initModel : Model
initModel =
    Model 0 "Hello World,\nMy name is Allan Nozomu,\nI'm a Software Developer" "" Writing


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



---- UPDATE ----


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.writingStatus == Pause then
        Sub.none

    else
        Time.every 25 Tick



---- UPDATE ----


type Msg
    = Tick Time.Posix
    | ChangePage String
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            let
                newPosition =
                    case model.writingStatus of
                        Pause ->
                            model.currentPosition

                        Writing ->
                            Basics.min (model.currentPosition + 1) (String.length model.currentHeader)

                        Clearing ->
                            Basics.max (model.currentPosition - 1) 0

                ( newHeader, newStatus ) =
                    if model.writingStatus == Writing && newPosition /= String.length model.currentHeader then
                        ( model.currentHeader, Writing )

                    else if model.writingStatus == Clearing && newPosition /= 0 then
                        ( model.currentHeader, Clearing )

                    else if model.writingStatus == Clearing && newPosition == 0 then
                        ( model.nextHeader, Writing )

                    else
                        ( model.currentHeader, Pause )
            in
            ( { model | writingStatus = newStatus, currentPosition = newPosition, currentHeader = newHeader }, Cmd.none )

        ChangePage newHeader ->
            if newHeader == model.currentHeader then
                ( model, Cmd.none )

            else
                ( { model | nextHeader = newHeader, writingStatus = Clearing }, Task.perform Tick Time.now )

        NoOp ->
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
            [ div
                [ class "item"
                , title "Home"
                , onClick <| ChangePage "Hello World,\nMy name is Allan Nozomu,\nI'm a Software Developer"
                ]
                [ Icons.home ]
            , div
                [ class "item"
                , title "Projects"
                , onClick <| ChangePage "My Projects (WIP)"
                ]
                [ Icons.code ]
            , div
                [ class "item"
                , title "Blog"
                , onClick <| ChangePage "My Blog (WIP)"
                ]
                [ Icons.penTool ]
            ]
        , div [ id "lowerMenu" ]
            [ div [ class "item", title "Github" ]
                [ a [ href "https://github.com/allannozomu", target "#" ] [ Icons.github ]
                ]
            , div [ class "item", title "Linkedin" ]
                [ a [ href "https://www.linkedin.com/in/allan-nozomu/", target "#" ] [ Icons.linkedin ]
                ]
            ]
        ]


containerBody : Model -> Html Msg
containerBody model =
    div [ id "containerBody" ]
        [ pre [ class "title" ] [ text <| String.left model.currentPosition model.currentHeader, span [ class "titleBlink" ] [ text "|" ] ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
