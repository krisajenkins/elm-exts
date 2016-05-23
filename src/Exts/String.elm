module Exts.String exposing (..)

{-| Extensions to the core `String` library.

@docs removePrefix

-}

import String exposing (dropLeft, length, startsWith)


{-| Strip a leading string from a `String`.
-}
removePrefix : String -> String -> String
removePrefix prefix s =
    if (startsWith prefix s) then
        dropLeft (length prefix) s
    else
        s
