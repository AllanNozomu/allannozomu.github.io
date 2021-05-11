module Main exposing (..)

import Browser
import Html exposing (Html, a, div, pre, span, text)
import Html.Attributes exposing (class, href, id, target, title)
import Html.Events exposing (onClick)
import Icons
import Task
import Time
import Markdown



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
        Time.every 15 Tick



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
            , div
                [ class "item"
                , title "Me"
                , onClick <| ChangePage "My Bio (WIP)"
                ]
                [ Icons.smile ]
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

type alias Options =
    { githubFlavored :
          Maybe
              { tables : Bool
              , breaks : Bool
              }
    , defaultHighlighting : Maybe String
    , sanitize : Bool
    , smartypants : Bool
    }

containerBody : Model -> Html Msg
containerBody model =
    div [ id "containerBody" ]
        [ pre [ class "title" ] [ text <| String.left model.currentPosition model.currentHeader, span [ class "titleBlink" ] [ text "|" ] ]
        , div [ id "contentBody" ]
            [ div [ id "contentWrapper" ]
                [content model]
            ]
        ]

content : Model -> Html Msg
content model = 
    case (model.currentHeader, model.nextHeader, model.writingStatus) of
        ("My Blog (WIP)", _, Clearing) -> div[class "fadeout"][markdownContent]
        (_, "My Blog (WIP)", Writing) -> div[class "fadein"][markdownContent]
        (_, "My Blog (WIP)", Pause) -> div[class "fadein"][markdownContent]
        _ -> div[class "fadeout"][]

myOptions : Options
myOptions =
    { githubFlavored = Just { tables = True, breaks = False }
    , defaultHighlighting = Nothing
    , sanitize = False
    , smartypants = True
    }

markdownContent : Html msg
markdownContent =
   Markdown.toHtmlWith  myOptions [class "markdownContent"] """

# Headings
# h1
## h2
### h3
#### h4
##### h5
###### h6

# Emphasis

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

# Text

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque iaculis imperdiet congue. Curabitur et pulvinar justo, ac pretium elit. Vivamus et tincidunt purus. Phasellus dignissim mauris nec enim elementum vestibulum. Aenean vestibulum odio ut dapibus blandit. Duis id enim vel ligula auctor scelerisque nec nec elit. Donec orci nunc, tincidunt quis ultrices vitae, sagittis eget ligula. Nunc cursus quam quis tincidunt tempus. In et vulputate nibh. Suspendisse potenti. Aliquam id nisl in nulla ullamcorper vestibulum. Phasellus molestie eget sem sed bibendum. Donec porttitor risus ac dolor venenatis pretium. Fusce sed enim vitae justo tempus pharetra. In dapibus, elit in facilisis blandit, massa felis fringilla lectus, sed accumsan tortor nibh sit amet nisi. Duis eget nunc sit amet urna maximus malesuada non nec augue.

Sed elit nisi, elementum quis leo nec, imperdiet viverra dui. Ut pharetra nunc et commodo hendrerit. Etiam sit amet sem ut nisl scelerisque tristique. Suspendisse felis urna, venenatis quis ultricies sed, sodales eget magna. Donec nibh ligula, imperdiet nec molestie nec, aliquam vel risus. Pellentesque gravida elit et justo vestibulum, eu tempus augue ullamcorper. Fusce laoreet magna ut lorem faucibus, sit amet consectetur diam pulvinar. Etiam congue, quam vitae auctor tempor, tellus nunc pretium quam, a venenatis odio nisi at mi. Nunc faucibus felis non dolor eleifend, et tempus nisi aliquam. Vivamus vitae velit fermentum, cursus nisl hendrerit, rutrum mi. Aenean gravida sodales lectus nec bibendum. Aliquam dignissim gravida sem, sit amet molestie risus consectetur non. Phasellus a ligula at mi scelerisque tincidunt. Fusce accumsan vitae erat sit amet pharetra. Ut volutpat arcu in orci finibus mattis. Aliquam ornare aliquam rutrum.

Aliquam erat volutpat. Aenean hendrerit tortor mauris, sed porta velit scelerisque id. Integer mattis quam ligula, non bibendum urna vestibulum sed. Duis interdum venenatis ex, ut ullamcorper diam euismod in. Sed aliquam auctor diam, a consectetur ipsum scelerisque vel. Fusce turpis dolor, iaculis sed dictum non, porta a ipsum. Nullam rutrum nibh nec sapien pellentesque luctus. Praesent nibh lacus, elementum sit amet sagittis id, maximus vitae metus. Nam eros orci, vehicula eget convallis id, luctus a neque. Donec nec egestas sem. Proin pharetra porta mauris et rhoncus. Donec nec luctus purus. Proin id ante non nibh imperdiet molestie.

# Quotes

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat nec urna nec venenatis. Curabitur mollis nisl at hendrerit lobortis. Maecenas quam sapien, aliquam nec ornare at, sagittis in est. Nullam malesuada ligula ac augue eleifend venenatis. Cras interdum risus eu suscipit faucibus. Nam eget sem ipsum. Aliquam erat volutpat. In libero sem, rhoncus ac bibendum non, finibus a nibh. Quisque tempus erat massa, vitae bibendum tortor consectetur consectetur. Etiam blandit ullamcorper quam vel condimentum. Nulla finibus mi vel accumsan dignissim. Sed fermentum nunc neque, sed lacinia risus lacinia et. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac tortor eu felis ultricies ullamcorper. In hac habitasse platea dictumst. Donec feugiat pretium libero eget faucibus.
> ###### Lorem Ipsum

Another

> Navegar eh preciso.

# List

- First element
- Second element
    - First sub element
        - First sub sub element
    - Second sub element
- Third element 

# Ordered List

1. First element
1. Second element
    1. First sub element
        1. First sub sub element
    1. Second sub element
1. Third element

# Link 

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

# Horizontal rule

---

# Code

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```
 
```python
s = "Python syntax highlighting"
print s
```
 
```
No language indicated, so no syntax highlighting. 
But let's throw in a <b>tag</b>.
```

"""


---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
