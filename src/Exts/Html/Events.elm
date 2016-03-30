module Exts.Html.Events (onEnter, onCheckbox) where

{-| Extensions to the Html.Events library.

@docs onEnter, onCheckbox
-}

import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode exposing (customDecoder)
import Signal exposing (Message, Address)


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
