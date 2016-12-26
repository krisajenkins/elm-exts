module Exts.Float exposing (..)

{-| Extensions to the core `Float` library.

@docs roundTo

@docs toSigFigs
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


{-| Round a `Float` to a given number of significant figures
-}
toSigFigs : Int -> Float -> Float
toSigFigs sigFigs x =
    if x == 0 then
        0
    else
        let
            absX =
                abs x

            logX =
                logBase 10 absX

            floorLogX =
                floor logX

            roundPlaces =
                -(floorLogX - (sigFigs - 1))
        in
            roundTo roundPlaces x
