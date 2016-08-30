module Exts.Array
    exposing
        ( update
        , unzip
        )

{-| Extensions to the core `Array` library.

@docs update
@docs unzip
-}

import Array exposing (..)


{-| 'Update' the entry at position `n`, by applying `f` to it. If the
index is out of range, the array is unaltered.
-}
update : Int -> (a -> a) -> Array a -> Array a
update n f xs =
    case get n xs of
        Nothing ->
            xs

        Just x ->
            set n (f x) xs


{-| Split an array of pairs into a pair of arrays.

The same as the core `List.unzip`.
-}
unzip : Array ( a, b ) -> ( Array a, Array b )
unzip =
    let
        reducer ( x, y ) ( xs, ys ) =
            ( push x xs
            , push y ys
            )
    in
        foldl reducer ( empty, empty )
