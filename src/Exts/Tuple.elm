module Exts.Tuple where

{-| Extensions for tuples.

@docs indexedPair

-}

{-| Turn a items into a key-value pair.

  See also `Exts.Dict.indexBy` and `Exts.Dict.groupBy`.
-}

indexedPair : (a -> b) -> a -> (b,a)
indexedPair f x = (f x, x)
