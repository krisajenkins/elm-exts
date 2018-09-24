module Exts.Html.Bootstrap exposing
    ( stylesheet
    , container
    , containerFluid
    , row
    , col
    , GridWidths
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
@docs col
@docs GridWidths
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


{-| Bootstrap grid width elements. To be used as:

    div
        [ classList
            [ col.xs.s12
            , col.md.s3
            ]
        ]
        ...

It doesn't save typing, but it does save _typos_, and that's worth having.

-}
col :
    { xs : GridWidths
    , sm : GridWidths
    , md : GridWidths
    , lg : GridWidths
    }
col =
    { xs =
        { s1 = "col-xs-1"
        , s2 = "col-xs-2"
        , s3 = "col-xs-3"
        , s4 = "col-xs-4"
        , s5 = "col-xs-5"
        , s6 = "col-xs-6"
        , s7 = "col-xs-7"
        , s8 = "col-xs-8"
        , s9 = "col-xs-9"
        , s10 = "col-xs-10"
        , s11 = "col-xs-11"
        , s12 = "col-xs-12"
        }
    , sm =
        { s1 = "col-sm-1"
        , s2 = "col-sm-2"
        , s3 = "col-sm-3"
        , s4 = "col-sm-4"
        , s5 = "col-sm-5"
        , s6 = "col-sm-6"
        , s7 = "col-sm-7"
        , s8 = "col-sm-8"
        , s9 = "col-sm-9"
        , s10 = "col-sm-10"
        , s11 = "col-sm-11"
        , s12 = "col-sm-12"
        }
    , md =
        { s1 = "col-md-1"
        , s2 = "col-md-2"
        , s3 = "col-md-3"
        , s4 = "col-md-4"
        , s5 = "col-md-5"
        , s6 = "col-md-6"
        , s7 = "col-md-7"
        , s8 = "col-md-8"
        , s9 = "col-md-9"
        , s10 = "col-md-10"
        , s11 = "col-md-11"
        , s12 = "col-md-12"
        }
    , lg =
        { s1 = "col-lg-1"
        , s2 = "col-lg-2"
        , s3 = "col-lg-3"
        , s4 = "col-lg-4"
        , s5 = "col-lg-5"
        , s6 = "col-lg-6"
        , s7 = "col-lg-7"
        , s8 = "col-lg-8"
        , s9 = "col-lg-9"
        , s10 = "col-lg-10"
        , s11 = "col-lg-11"
        , s12 = "col-lg-12"
        }
    }


{-| Bootstrap grid width definitions. See `col` for usage.
-}



-- TODO Worry about offset & pull.


type alias GridWidths =
    { s1 : String
    , s2 : String
    , s3 : String
    , s4 : String
    , s5 : String
    , s6 : String
    , s7 : String
    , s8 : String
    , s9 : String
    , s10 : String
    , s11 : String
    , s12 : String
    }


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


styles : List ( String, String ) -> List (Attribute msg)
styles =
    List.map (\( name, value ) -> style name value)


{-| Interface to the bootstrap popover that does not require bootstrap.js.
-}
popover : PopoverDirection -> Bool -> List ( String, String ) -> Maybe String -> Html msg -> Html msg
popover direction isShown styleList title body =
    div
        ([ classList
            [ ( "popover fade", True )
            , ( "in", isShown )
            , ( "top", direction == Top )
            , ( "right", direction == Right )
            , ( "bottom", direction == Bottom )
            , ( "left", direction == Left )
            ]
         ]
            ++ styles
                (styleList
                    ++ [ ( "display", "block" ) ]
                )
        )
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
