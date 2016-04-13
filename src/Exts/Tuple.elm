module Exts.Tuple (indexedPair, first, second, both, pair, fork) where

{-| Extensions for tuples.

@docs indexedPair, first, second, both, pair, fork

-}


{-| Turn a items into a key-value pair.

  See also `Exts.Dict.indexBy` and `Exts.Dict.groupBy`.
-}
indexedPair : (a -> b) -> a -> ( b, a )
indexedPair f x =
  ( f x, x )


{-| Update the first component of a pair.
-}
first : (a -> a') -> ( a, b ) -> ( a', b )
first f ( x, y ) =
  ( f x, y )


{-| Update the second component of a pair.
-}
second : (b -> b') -> ( a, b ) -> ( a, b' )
second f ( x, y ) =
  ( x, f y )


{-| Update both components of a pair with a single function.
-}
both : (a -> b) -> ( a, a ) -> ( b, b )
both f ( x, y ) =
  ( f x, f y )


{-| Update both components of a pair with two functions.
-}
pair : (a -> a') -> (b -> b') -> ( a, b ) -> ( a', b' )
pair fX fY ( x, y ) =
  ( fX x, fY y )


{-| Generate a pair from a single value and a left & right function.
-}
fork : (a -> b) -> (a -> c) -> a -> ( b, c )
fork fX fY v =
  ( fX v, fY v )
