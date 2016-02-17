module Exts.Html.Attributes (defaultValue, defaultString, defaultInt, defaultFloat) where

{-| Extensions to the Html.Attributes library.

@docs defaultValue, defaultString, defaultInt, defaultFloat
-}

import Html exposing (Attribute)
import Html.Attributes exposing (property)
import Json.Encode


{-| Set a default value for an input field.
-}
defaultValue : Json.Encode.Value -> Attribute
defaultValue =
  property "defaultValue"


{-| Convenience version of defaultValue, for `String`s.
-}
defaultString : String -> Attribute
defaultString =
  defaultValue << Json.Encode.string


{-| Convenience version of defaultValue, for `Int`s.
-}
defaultInt : Int -> Attribute
defaultInt =
  defaultValue << Json.Encode.int


{-| Convenience version of defaultValue, for `Float`s.
-}
defaultFloat : Float -> Attribute
defaultFloat =
  defaultValue << Json.Encode.float
