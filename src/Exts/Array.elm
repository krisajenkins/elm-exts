module Exts.Array
    exposing
        ( update
        , delete
        , unzip
        , singleton
        )

{-| Extensions to the core `Array` library.

@docs update
@docs delete
@docs unzip
@docs singleton
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


{-| 'Delete' the entry at position `n`.
index is out of range, the array is unaltered.
-}
delete : Int -> Array a -> Array a
delete n xs =
    if n < 0 then
        xs
    else
        let
            before =
                slice 0 n xs

            after =
                (slice (n + 1) (Array.length xs) xs)
        in
            Array.append before after


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


{-| Wrap a single item into an `Array`.
-}
singleton : a -> Array a
singleton x =
    push x empty
