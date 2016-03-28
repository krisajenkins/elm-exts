module Exts.Tuple (indexedPair, first, second, both, (***), (&&&)) where

{-| Extensions for tuples.

@docs indexedPair, first, second, both, (***), (&&&)

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


{-| Update both components of a pair.
-}
both : (a -> b) -> ( a, a ) -> ( b, b )
both f ( x, y ) =
  ( f x, f y )


{-| Update the both components of a pair.
-}
(***) : (a -> a') -> (b -> b') -> ( a, b ) -> ( a', b' )
(***) fX fY ( x, y ) =
  ( fX x, fY y )


{-| Generate a pair from a single value and a left & right function.
-}
(&&&) : (a -> b) -> (a -> c) -> a -> ( b, c )
(&&&) fX fY v =
  ( fX v, fY v )


infixr 3 ***
infixr 3 &&&
