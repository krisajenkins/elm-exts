module Exts.Json.Decode
    exposing
        ( stringIgnoringBlanks
        , decodeTime
        , decodeDate
        )

{-| Extensions to the core `Json.Decode` library.

@docs stringIgnoringBlanks
@docs decodeTime
@docs decodeDate
-}

import Date exposing (Date)
import Json.Decode exposing (..)
import String


{-| A decoder like `(maybe string)`, except an empty or whitespace string is treated as `Nothing`.

Useful for dirty data-models.
-}
stringIgnoringBlanks : Decoder (Maybe String)
stringIgnoringBlanks =
    andThen (maybe string)
        (\maybeString ->
            succeed (Maybe.andThen maybeString parseEmptyOrString)
        )


parseEmptyOrString : String -> Maybe String
parseEmptyOrString string =
    if String.isEmpty (String.trim string) then
        Nothing
    else
        Just string


{-| Decode a Date from seconds-since-the-epoch.
-}
decodeTime : Decoder Date
decodeTime =
    map Date.fromTime float


{-| Decode a Date from a string, using the same format as the core
function `Date.fromString`.
-}
decodeDate : Decoder Date
decodeDate =
    customDecoder string Date.fromString
