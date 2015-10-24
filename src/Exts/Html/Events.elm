module Exts.Html.Events
  (onEnter)
  where

{-| Extensions to the Html.Events library.

@docs onEnter
-}

import Html exposing (Attribute)
import Html.Events exposing (onWithOptions, keyCode)
import Json.Decode exposing (customDecoder)
import Signal exposing (Message)

keyCodeIs : Int -> Int -> Result String ()
keyCodeIs expected actual =
  if expected == actual
  then Ok ()
  else Err "Not the right key code"

enterKey : Int -> Result String ()
enterKey = keyCodeIs 13

{-| Send a message when the user hits enter. -}
onEnter : Message -> Attribute
onEnter message =
    onWithOptions
      "keydown"
      {preventDefault = True
      ,stopPropagation = False}
      (customDecoder keyCode enterKey)
      (always message)
