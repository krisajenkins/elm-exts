module Exts.Json.Decode exposing (stringIgnoringBlanks)

{-| Extensions to the core `Json.Decode` library.

@docs stringIgnoringBlanks
-}

import Json.Decode exposing (..)
import String


{-| A decoder like `(maybe string)`, except an empty or whitespace string is treated as `Nothing`.

Useful for dirty data-models.
-}
stringIgnoringBlanks : Decoder (Maybe String)
stringIgnoringBlanks =
    maybe string
        `andThen` \maybeString ->
                    succeed (maybeString `Maybe.andThen` parseEmptyOrString)


parseEmptyOrString : String -> Maybe String
parseEmptyOrString string =
    if String.isEmpty (String.trim string) then
        Nothing
    else
        Just string
