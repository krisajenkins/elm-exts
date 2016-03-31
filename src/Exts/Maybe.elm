module Exts.Maybe (..) where

{-| Extensions to the core `Maybe` library.

@docs isJust, isNothing, maybe, mappend, catMaybes
-}

import Maybe exposing (withDefault)


{-| Boolean checks.
-}
isJust : Maybe a -> Bool
isJust x =
  case x of
    Just _ ->
      True

    _ ->
      False


{-| -}
isNothing : Maybe a -> Bool
isNothing =
  not << isJust


{-| Apply a function to a value, returning the default if the value is `Nothing`.
-}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default f =
  withDefault default << Maybe.map f


{-| Join two `Maybe`s together as though they were one.
-}
mappend : Maybe a -> Maybe b -> Maybe ( a, b )
mappend a b =
  case ( a, b ) of
    ( Nothing, _ ) ->
      Nothing

    ( _, Nothing ) ->
      Nothing

    ( Just x, Just y ) ->
      Just ( x, y )


{-| Extract all the `Just` values from a List of Maybes.
-}
catMaybes : List (Maybe a) -> List a
catMaybes xs =
  case xs of
    [] ->
      []

    Nothing :: xs' ->
      catMaybes xs'

    (Just x) :: xs' ->
      x :: catMaybes xs'
