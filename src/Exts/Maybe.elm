module Exts.Maybe where

{-| Extensions to the core Maybe library. |-}

import Maybe

isJust : Maybe a -> Bool
isJust x = case x of
             Just _ -> True
             _ -> False

maybeString : Maybe String -> String
maybeString = Maybe.withDefault ""

maybeNumber : Maybe num -> String
maybeNumber x =
  case x of
    Nothing -> ""
    Just x -> toString x

mapMaybe : (comparable -> Maybe b) -> List comparable -> List b
mapMaybe f xs =
  case xs of
    [] -> []
    (x::ys) -> case f x of
                 Nothing -> mapMaybe f ys
                 Just y -> y :: mapMaybe f ys
