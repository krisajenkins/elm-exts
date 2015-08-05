module Exts.Maybe where

{-| Extensions to the core Maybe library.

@docs isJust, isNothing, maybeString, maybeNumber, maybe
-}

import Maybe exposing (withDefault)

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

{-| Apply a function to a value, returning the default if the function returns Nothing. -}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default f = withDefault default << Maybe.map f
