module Exts.SafeList (
  safeHead,
  tailMaybe,

  lookup
  ) where

{-| A safe version of the List library, following Haskell's Safe.
-}

import List
import Maybe

{-| Create a Maybe from a, based on a predicate.
    If the predicate returns true, return Just x, otherwise Nothing.
-}
pred : (a -> Bool) -> a -> Maybe a
pred p x = if | p x -> Just x
              | otherwise -> Nothing

{-| If predicate returns true, apply f to a, returning (Just (f xs)).
    If the predicate returns false, return Nothing.
-}
may : (a -> Bool) -> (a -> b) -> a -> Maybe b
may p f = Maybe.map f << pred p

safeHead : List a -> Maybe a
safeHead = may (not << List.isEmpty) List.head

tailMaybe : List a -> Maybe (List a)
tailMaybe = may (not << List.isEmpty) List.tail

lookup : (a -> Bool) -> List a -> Maybe a
lookup f xs = List.filter f xs |> safeHead
