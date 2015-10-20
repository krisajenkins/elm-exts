module Exts.Date where

{-| Extensions to the core date library.

@docs toISOString
-}

import Date exposing (Date)
import Date.TimeStamp exposing (..)
import String

{-| Format a Date as an ISO-standard string. -}
toISOString : Date -> String
toISOString d =
  let ts = fromDate d
  in (toString ts.year        |> String.padLeft 2 '0') ++ "-" ++
     (toString ts.month       |> String.padLeft 2 '0') ++ "-" ++
     (toString ts.day         |> String.padLeft 2 '0') ++ "T" ++
     (toString (ts.hour - 1)  |> String.padLeft 2 '0') ++ ":" ++
     (toString ts.minute      |> String.padLeft 2 '0') ++ ":" ++
     (toString ts.second      |> String.padLeft 2 '0') ++ "." ++
     (toString ts.millisecond |> String.padLeft 2 '0') ++ "Z"
