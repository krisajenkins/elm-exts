module Exts.SafeList (
  lookup
  ) where

{-| A safe version of the List library, following Haskell's Safe.
-}

lookup : (a -> Bool) -> List a -> Maybe a
lookup f xs = List.filter f xs |> List.head
