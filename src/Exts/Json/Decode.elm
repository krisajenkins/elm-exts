module Exts.Json.Decode
    exposing
        ( stringIgnoringBlanks
        , decodeTime
        , decodeDate
        , parseWith
        , customDecoder
        , set
        , exactlyOne
        , decodeEmptyObject
        )

{-| Extensions to the core `Json.Decode` library.

@docs stringIgnoringBlanks
@docs decodeTime
@docs decodeDate
@docs parseWith
@docs customDecoder
@docs set
@docs exactlyOne
@docs decodeEmptyObject
-}

import Date exposing (Date)
import Dict
import Json.Decode exposing (..)
import Set exposing (Set)
import String


{-| A decoder like `(maybe string)`, except an empty or whitespace string is treated as `Nothing`.

Useful for dirty data-models.
-}
stringIgnoringBlanks : Decoder (Maybe String)
stringIgnoringBlanks =
    (maybe string)
        |> andThen
            (\maybeString ->
                succeed
                    (maybeString
                        |> Maybe.andThen parseEmptyOrString
                    )
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


{-| DEPRECATED: Use customDecoder instead.

Lift a function that parses things, returning a `Result`, into the world of decoders.

If you're looking for the pre-0.18 function `customDecoder`, you can
use something like this instead:

``` elm
decodeUUID : Decoder UUID
decodeUUID =
    string
        |> andThen (parseWith UUID.fromString)
```
-}
parseWith : (a -> Result String b) -> a -> Decoder b
parseWith f input =
    case f input of
        Err e ->
            fail e

        Ok value ->
            succeed value


{-| Decode a Date from a string, using the same format as the core
function `Date.fromString`.
-}
decodeDate : Decoder Date
decodeDate =
    customDecoder string Date.fromString


{-| Combine a primitive decoder and a parser to make a more sophisticated decoder.
-}
customDecoder : Decoder a -> (a -> Result String b) -> Decoder b
customDecoder decoder parser =
    decoder
        |> andThen
            (\s ->
                case parser s of
                    Err e ->
                        fail e

                    Ok v ->
                        succeed v
            )


{-| Decode a JSON array of things directly into a `Set`.
-}
set : Decoder comparable -> Decoder (Set comparable)
set =
    list >> map Set.fromList


{-| Expects a list where *exactly* one element will succeed with the given decoder.
-}
exactlyOne : Decoder a -> Decoder a
exactlyOne decoder =
    list (maybe decoder)
        |> andThen
            (\results ->
                let
                    successes =
                        List.filterMap identity results
                in
                    case successes of
                        [ x ] ->
                            succeed x

                        _ ->
                            fail <| "Expected exactly one matching element. Got: " ++ toString (List.length successes)
            )


{-| Decode the empty object as the value given, and fail otherwise.
-}
decodeEmptyObject : a -> Decoder a
decodeEmptyObject default =
    dict value
        |> andThen
            (\aDict ->
                if Dict.isEmpty aDict then
                    succeed default
                else
                    fail "Expected {}"
            )
