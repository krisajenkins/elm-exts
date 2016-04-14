module Exts.Html.Events (onEnter, onCheckbox, onSelect, onInput) where

{-| Extensions to the `Html.Events` library.

@docs onEnter, onCheckbox, onSelect, onInput
-}

import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (customDecoder, Decoder)
import Signal exposing (Message, Address, message)


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
onEnter : Message -> Attribute
onEnter message =
  onWithOptions
    "keydown"
    { preventDefault = True
    , stopPropagation = False
    }
    (customDecoder keyCode enterKey)
    (always message)


{-| Send a message whenever a checkbox is clicked. You supply a
`function` which takes a `Bool` and returns an appropriate message.
-}
onCheckbox : Address a -> (Bool -> a) -> Attribute
onCheckbox address function =
  on
    "change"
    targetChecked
    (Signal.message address << function)


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
onSelect : Address a -> (Maybe String -> a) -> Attribute
onSelect address f =
  on
    "change"
    maybeTargetValue
    (message address << f)


{-| Similar to onChange, but it fires as soon as the value has changed,
whereas onChange waits until the input loses focus.
-}
onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on
    "input"
    targetValue
    (message address << f)
