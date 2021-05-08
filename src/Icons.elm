module Icons exposing
    ( code
    , github
    , home
    , linkedin
    , penTool
    , smile
    , tool
    )

import Html exposing (Html)
import Svg exposing (Svg, svg)
import Svg.Attributes exposing (..)


svgFeatherIcon : String -> List (Svg msg) -> Html msg
svgFeatherIcon className =
    svg
        [ class <| "feather feather-" ++ className
        , fill "none"
        , height "36"
        , stroke "currentColor"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        , strokeWidth "1"
        , viewBox "0 0 24 24"
        , width "36"
        ]


code : Html msg
code =
    svgFeatherIcon "code"
        [ Svg.polyline [ points "16 18 22 12 16 6" ] []
        , Svg.polyline [ points "8 6 2 12 8 18" ] []
        ]


github : Html msg
github =
    svgFeatherIcon "github"
        [ Svg.path [ d "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22" ] []
        ]


home : Html msg
home =
    svgFeatherIcon "home"
        [ Svg.path [ d "M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" ] []
        , Svg.polyline [ points "9 22 9 12 15 12 15 22" ] []
        ]


linkedin : Html msg
linkedin =
    svgFeatherIcon "linkedin"
        [ Svg.path [ d "M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z" ] []
        , Svg.rect [ Svg.Attributes.x "2", y "9", width "4", height "12" ] []
        , Svg.circle [ cx "4", cy "4", r "2" ] []
        ]


penTool : Html msg
penTool =
    svgFeatherIcon "pen-tool"
        [ Svg.path [ d "M12 19l7-7 3 3-7 7-3-3z" ] []
        , Svg.path [ d "M18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5z" ] []
        , Svg.path [ d "M2 2l7.586 7.586" ] []
        , Svg.circle [ cx "11", cy "11", r "2" ] []
        ]


tool : Html msg
tool =
    svgFeatherIcon "tool"
        [ Svg.path [ d "M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z" ] []
        ]


smile : Html msg
smile =
    svgFeatherIcon "smile"
        [ Svg.circle [ cx "12", cy "12", r "10" ] []
        , Svg.path [ d "M8 14s1.5 2 4 2 4-2 4-2" ] []
        , Svg.line [ x1 "9", y1 "9", x2 "9.01", y2 "9" ] []
        , Svg.line [ x1 "15", y1 "9", x2 "15.01", y2 "9" ] []
        ]
