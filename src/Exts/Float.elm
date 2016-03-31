module Exts.Float (..) where

{-| Extensions to the core `Float` library.

@docs roundTo
-}


{-| Round a `Float` to a given number of decimal places.
-}
roundTo : Int -> Float -> Float
roundTo places =
  let
    factor =
      10 ^ places
  in
    (*) factor >> round >> toFloat >> (\n -> n / factor)
