module Exts.Json.Encode exposing
    ( tuple2
    , maybe
    )

{-| Extensions to the core `Json.Encode` library.

@docs tuple2
@docs maybe

-}

import Dict exposing (Dict)
import Json.Encode exposing (..)
import Set as Set exposing (Set)


{-| Encode a pair to a JSON array .
-}
tuple2 : (a -> Value) -> (b -> Value) -> ( a, b ) -> Value
tuple2 encodeKey encodeValue ( x, y ) =
    list identity [ encodeKey x, encodeValue y ]


{-| Encode a `Maybe` value, encoding `Nothing` as `null`.
-}
maybe : (a -> Value) -> Maybe a -> Value
maybe encoder value =
    case value of
        Nothing ->
            null

        Just v ->
            encoder v
