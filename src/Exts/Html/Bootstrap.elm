module Exts.Html.Bootstrap
    exposing
        ( stylesheet
        , container
        , containerFluid
        , row
        , formGroup
        , empty
        , twoColumns
        , Ratio(..)
        , video
        , popover
        , PopoverDirection(..)
        , clearfix
        , well
        , jumbotron
        , badge
        )

{-| Base classes for Twitter Bootstrap 3 users.

@docs stylesheet
@docs container
@docs containerFluid
@docs row
@docs formGroup
@docs empty
@docs twoColumns
@docs Ratio
@docs video
@docs popover
@docs PopoverDirection
@docs clearfix
@docs well
@docs jumbotron
@docs badge
-}

import Html exposing (..)
import Html.Attributes exposing (..)


{-| A tag that loads Bootstrap from a CDN.

You'll probably only want to use this to get you started. By the time you go
into production, you should probably be loading this file in the `<head>` tag
of your page.
-}
stylesheet : Html msg
stylesheet =
    node "link"
        [ rel "stylesheet"
        , href "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
        ]
        []


{-| Bootstrap grid container.
-}
container : List (Html msg) -> Html msg
container =
    div [ class "container" ]


{-| Bootstrap grid fluid container.
-}
containerFluid : List (Html msg) -> Html msg
containerFluid =
    div [ class "container-fluid" ]


{-| Bootstrap grid row.
-}
row : List (Html msg) -> Html msg
row =
    div [ class "row" ]


{-| Bootstrap form group.
-}
formGroup : List (Html msg) -> Html msg
formGroup =
    div [ class "form-group" ]


{-| The minimum markup - an empty span.
-}
empty : Html msg
empty =
    span [] []


{-| Two evenly-sized columns.
-}
twoColumns : List (Html msg) -> List (Html msg) -> Html msg
twoColumns left right =
    row
        [ div [ class "col-xs-6" ] left
        , div [ class "col-xs-6" ] right
        ]


{-| Bootstrap clearfix.
-}
clearfix : Html msg
clearfix =
    div [ class "clearfix" ] []


{-| Bootstrap jumbotron component.
-}
jumbotron : List (Html msg) -> Html msg
jumbotron =
    div [ class "jumbotron" ]


{-| Bootstrap well component.
-}
well : List (Html msg) -> Html msg
well =
    div [ class "well" ]


{-| Bootstrap badge component.
-}
badge : List (Html msg) -> Html msg
badge =
    span [ class "badge" ]


{-| Aspect ratios for responsive video embedding.
-}
type Ratio
    = SixteenByNine
    | FourByThree


{-| Embed a responsive video.
-}
video : Ratio -> String -> Html msg
video ratio url =
    let
        ratioClass =
            case ratio of
                SixteenByNine ->
                    "embed-responsive-16by9"

                FourByThree ->
                    "embed-responsive-4by3"
    in
        div []
            [ h1 [] [ text "About" ]
            , div [ class "embed-responsive" ]
                [ iframe
                    [ class "embed-responsive-item"
                    , src url
                    ]
                    []
                ]
            ]



------------------------------------------------------------
-- Popovers
------------------------------------------------------------


{-| -}
type PopoverDirection
    = Top
    | Right
    | Bottom
    | Left


{-| Interface to the bootstrap popover that does not require bootstrap.js.
-}
popover : PopoverDirection -> Bool -> List ( String, String ) -> Maybe String -> Html msg -> Html msg
popover direction isShown styles title body =
    div
        [ classList
            [ ( "popover fade", True )
            , ( "in", isShown )
            , ( "top", (direction == Top) )
            , ( "right", (direction == Right) )
            , ( "bottom", (direction == Bottom) )
            , ( "left", (direction == Left) )
            ]
        , style
            (styles
                ++ [ ( "display", "block" ) ]
            )
        ]
        [ div [ class "arrow" ]
            []
        , case title of
            Just s ->
                h3 [ class "popover-title" ]
                    [ text s ]

            Nothing ->
                empty
        , div [ class "popover-content" ]
            [ body ]
        ]
