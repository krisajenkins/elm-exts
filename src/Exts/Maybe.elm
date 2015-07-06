module Exts.Maybe where

{-| Extensions to the core Maybe library.

@docs isJust, isNothing, maybeString, maybeNumber, mapMaybe
-}

import Maybe

{-| Boolean checks. -}
isJust : Maybe a -> Bool
isJust x = case x of
             Just _ -> True
             _ -> False

{-|-}
isNothing : Maybe a -> Bool
isNothing = not << isJust

{-| Simple transform for displaying Maybe Strings. -}
maybeString : Maybe String -> String
maybeString = Maybe.withDefault ""

{-| Simple transform for displaying Maybe nums. -}
maybeNumber : Maybe num -> String
maybeNumber x =
  case x of
    Nothing -> ""
    Just x -> toString x

{-| Run a function over a List, dropping items for which the function returns Nothing. -}
mapMaybe : (a -> Maybe b) -> List a -> List b
mapMaybe f xs =
  case xs of
    [] -> []
    (x::ys) -> case f x of
                 Nothing -> mapMaybe f ys
                 Just y -> y :: mapMaybe f ys
