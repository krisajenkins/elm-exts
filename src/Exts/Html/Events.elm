module Exts.Html.Events exposing (onEnter, onSelect)

{-| Extensions to the `Html.Events` library.

@docs onEnter
@docs onSelect
-}

import Exts.Json.Decode
import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Decoder)


keyCodeIs : Int -> Int -> Result String ()
keyCodeIs expected actual =
    if expected == actual then
        Ok ()
    else
        Err "Not the right key code"


enterKey : Int -> Result String ()
enterKey =
    keyCodeIs 13


{-| Send a message when the user hits enter.
-}
onEnter : msg -> Attribute msg
onEnter message =
    onWithOptions "keydown"
        { preventDefault = True
        , stopPropagation = False
        }
        (keyCode
            |> Decode.andThen (Exts.Json.Decode.parseWith enterKey)
            |> Decode.andThen (always (Decode.succeed message))
        )


emptyIsNothing : String -> Maybe String
emptyIsNothing s =
    if s == "" then
        Nothing
    else
        Just s


maybeTargetValue : Decoder (Maybe String)
maybeTargetValue =
    Decode.map emptyIsNothing targetValue


{-| An event handler for `<select>` tags. Set the child `<option>` tag's value to "" to get a `Nothing`.
-}
onSelect : (Maybe String -> msg) -> Attribute msg
onSelect f =
    on "change"
        (Decode.map f maybeTargetValue)
