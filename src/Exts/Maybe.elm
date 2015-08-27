module Exts.Maybe where

{-| Extensions to the core Maybe library.

@docs isJust, isNothing, maybe
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

{-| Apply a function to a value, returning the default if the function returns Nothing. -}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default f = withDefault default << Maybe.map f
