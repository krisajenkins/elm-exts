module Exts.Html.Attributes exposing (defaultValue, defaultString, defaultInt, defaultFloat, styleList)

{-| Extensions to the `Html.Attributes` library.

@docs defaultValue
@docs defaultString
@docs defaultInt
@docs defaultFloat
@docs styleList
-}

import Html exposing (Attribute)
import Html.Attributes exposing (property, style)
import Json.Encode


{-| Set a default value for an input field.
-}
defaultValue : Json.Encode.Value -> Attribute msg
defaultValue =
    property "defaultValue"


{-| Convenience version of `defaultValue`, for `String`s.
-}
defaultString : String -> Attribute msg
defaultString =
    defaultValue << Json.Encode.string


{-| Convenience version of `defaultValue`, for `Int`s.
-}
defaultInt : Int -> Attribute msg
defaultInt =
    defaultValue << Json.Encode.int


{-| Convenience version of `defaultValue`, for `Float`s.
-}
defaultFloat : Float -> Attribute msg
defaultFloat =
    defaultValue << Json.Encode.float


{-| This function makes it easier to specify a conditional set of styles.
   This the style-equivalent of elm-html's classList.
-}
styleList : List ( String, String, Bool ) -> Attribute msg
styleList =
    let
        withActive ( name, value, active ) =
            if active then
                Just ( name, value )
            else
                Nothing
    in
        List.filterMap withActive >> Html.Attributes.style
