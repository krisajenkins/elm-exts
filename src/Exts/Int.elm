module Exts.Int exposing (floorBy)

{-| Extensions to the core `Int` library.

@docs floorBy
-}


{-| Round an int down to the nearest multiple of a factor.

    floorBy  2 143 => Just 142
    floorBy 50 143 => Just 100
    floorBy  0 143 => Nothing
-}
floorBy : Int -> Int -> Maybe Int
floorBy factor n =
    if factor == 0 then
        Nothing
    else
        Just (factor * ((n // factor)))
