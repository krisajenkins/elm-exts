module Exts.Tuple
    exposing
        ( indexedPair
        , both
        , pair
        , fork
        , onFirst
        , onSecond
        )

{-| Extensions for tuples.

@docs indexedPair
@docs both
@docs pair
@docs fork
@docs onFirst
@docs onSecond

-}


{-| Turn a items into a key-value pair.

  See also `Exts.Dict.indexBy` and `Exts.Dict.groupBy`.
-}
indexedPair : (a -> b) -> a -> ( b, a )
indexedPair f x =
    ( f x, x )


{-| Update both components of a pair with a single function.
-}
both : (a -> b) -> ( a, a ) -> ( b, b )
both f =
    pair f f


{-| Update both components of a pair with two functions.
-}
pair : (a -> b) -> (x -> y) -> ( a, x ) -> ( b, y )
pair f1 f2 ( a, x ) =
    ( f1 a, f2 x )


{-| Generate a pair from a single value and a left & right function.
-}
fork : (a -> b) -> (a -> c) -> a -> ( b, c )
fork fX fY v =
    ( fX v, fY v )


{-| Apply a function that considers both elements of a pair and changes the first.
-}
onFirst : (a -> b -> c) -> ( a, b ) -> ( c, b )
onFirst f ( a, b ) =
    ( f a b, b )


{-| Apply a function that considers both elements of a pair and changes the second.
-}
onSecond : (a -> b -> c) -> ( a, b ) -> ( a, c )
onSecond f ( a, b ) =
    ( a, f a b )
