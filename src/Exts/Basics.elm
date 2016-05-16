module Exts.Basics exposing (..)

{-| Extensions to the core `Basics` library.

@docs compareBy

-}


{-| Compare two things by running the supplied function of both, and comparing the results.

-}
compareBy : (a -> comparable) -> a -> a -> Order
compareBy f a b =
  compare (f a) (f b)
