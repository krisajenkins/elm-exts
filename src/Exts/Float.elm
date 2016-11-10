module Exts.Float exposing (..)

{-| Extensions to the core `Float` library.

@docs roundTo
-}


{-| Round a `Float` to a given number of decimal places.
-}
roundTo : Int -> Float -> Float
roundTo places value =
    let
        factor =
            toFloat (10 ^ places)
    in
        ((value * factor)
            |> round
            |> toFloat
        )
            / factor
