module Exts.Date (toISOString) where

{-| Extensions to the core `Date` library.

@docs toISOString
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
