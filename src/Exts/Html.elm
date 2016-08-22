module Exts.Html exposing (matchText, nbsp)

{-| Extensions to the `Html` library.

@docs matchText
@docs nbsp

-}

import Exts.List exposing (rest)
import Html exposing (Html, Attribute, text, span)
import Regex exposing (Regex, HowMany(All), find)
import String exposing (length)


{-| Highlight regex matches in a given piece of text. This is most easily explained with an example:

    import Regex exposing (regex)
    import Html.Attributes exposing (class)

    matchText
      [class "match"]
      (regex "the")
      "the quick brown fox jumped over the lazy dog"

    =>

    [span [class "match"] [text "the"]
    ,text " quick brown fox jumped over "
    ,span [class "match"] [text "the"]
    ,text " lazy dog"]

    Now you can add a CSS rule like `.match {background-color: yellow;}` to highlight matches
    for the user.

    (Note that you can supply any attributes you like for the matched sections, or an empty list.)

-}
matchText : List (Attribute msg) -> Regex -> String -> List (Html msg)
matchText attributes search string =
    let
        matches =
            find All search string

        matchBoundaries place =
            [ ( place.index, True )
            , ( place.index + length place.match
              , False
              )
            ]

        matchStringStart =
            [ ( 0, False ) ]

        matchStringEnd =
            [ ( length string, False ) ]

        allSegmentBoundaries =
            matchStringStart
                ++ (List.concatMap matchBoundaries
                        matches
                   )
                ++ matchStringEnd

        sliceSegments ( start, match ) ( end, _ ) =
            span
                (if match then
                    attributes
                 else
                    []
                )
                [ text (String.slice start end string) ]
    in
        List.map2 sliceSegments
            allSegmentBoundaries
            (rest allSegmentBoundaries)


{-| A non-breaking space. elm-html doesn't support escape sequences
like `text "&nbsp"`, so use this string instead.
-}
nbsp : String
nbsp =
    " "
