module Exts.Date exposing (toISOString, monthNumber, toRFC3339)

{-| Extensions to the core `Date` library.

@docs toISOString
@docs toRFC3339
@docs monthNumber
-}

import Date exposing (..)
import String


{-| Format a Date as an ISO-standard string.
-}
toISOString : Date -> String
toISOString d =
    (toString (year d) |> String.padLeft 2 '0')
        ++ "-"
        ++ (toString (monthNumber d) |> String.padLeft 2 '0')
        ++ "-"
        ++ (toString (day d) |> String.padLeft 2 '0')
        ++ "T"
        ++ (toString ((hour d) - 1) |> String.padLeft 2 '0')
        ++ ":"
        ++ (toString (minute d) |> String.padLeft 2 '0')
        ++ ":"
        ++ (toString (second d) |> String.padLeft 2 '0')
        ++ "."
        ++ (toString (millisecond d) |> String.padLeft 3 '0')
        ++ "Z"


{-| Format a Date as an RFC-3339 standard string

  This is useful for passing a Date as a value to an html input
  see [the documentation](https://www.w3.org/TR/html-markup/input.date.html#input.date.attrs.value)
  for more informations
-}
toRFC3339 : Date -> String
toRFC3339 date =
    (toString <| Date.year date)
        ++ "-"
        ++ (String.padLeft 2 '0' <| toString <| monthNumber date)
        ++ "-"
        ++ (String.padLeft 2 '0' <| toString <| Date.day date)


{-| Extract the month of a given date as an integer. January is 1
-}
monthNumber : Date -> Int
monthNumber date =
    case month date of
        Jan ->
            1

        Feb ->
            2

        Mar ->
            3

        Apr ->
            4

        May ->
            5

        Jun ->
            6

        Jul ->
            7

        Aug ->
            8

        Sep ->
            9

        Oct ->
            10

        Nov ->
            11

        Dec ->
            12
