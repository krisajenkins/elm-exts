module Exts.Array (update) where

{-| Extensions to the core `Array` library.

@docs update
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
