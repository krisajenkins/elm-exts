module Exts.Validation exposing (..)

{-| Simple tools for validation. See also [Richard Feldman's elm-validate](http://package.elm-lang.org/packages/rtfeldman/elm-validate/latest).

@docs Validator
@docs apply
@docs (|:)
@docs required
@docs notBlank
@docs matches
@docs email
@docs emailRegex
-}

import Regex exposing (Regex, caseInsensitive, regex, contains)
import Result exposing (andThen)


{-| A validator is a function that takes a possibly-invalid form, and
either returns an error message, or a form that is definitely valid. For example:

    type alias Form =
      { message : Maybe String
      , email : Maybe String
      , firstName : Maybe String
      , age : Maybe Int
      }

    type alias ValidForm =
      { message : String
      , email : String
      , firstName : String
      , age : Int
      }

    validateForm : Form -> Result String ValidForm
    validateForm form =
      Ok ValidForm
        |: notBlank "Message is required and may not be blank." form.message
        |: email "Email is required and may not be blank." form.email
        |: matches (caseInsensitive (regex "^[a-z]+$")) "First name may only contain letters." form.firstName
        |: required "Age is required" form.age

An error message is typically a `String`, but may be any type you choose.
-}
type alias Validator e a b =
    Maybe a -> Result e b


{-| Chain validators together.

(Hat tip to CircuitHub, who inspired the syntax and guided the code with their [elm-json-extra](http://package.elm-lang.org/packages/circuithub/elm-json-extra/latest) library.)
-}
apply : Result e (a -> b) -> Result e a -> Result e b
apply f aResult =
    f
        |> andThen (\continuation -> Result.map continuation aResult)


{-| Convenient synonym for `apply`.
-}
(|:) : Result e (a -> b) -> Result e a -> Result e b
(|:) =
    apply


{-| A field that might be `Nothing`, but is only valid if it is `Just a`.
-}
required : e -> Validator e a a
required err =
    Result.fromMaybe err


{-| A field that might be `Nothing`, but is only valid if it is a non-empty `String`.
-}
notBlank : e -> Validator e String String
notBlank err str =
    case str of
        Nothing ->
            Err err

        Just "" ->
            Err err

        Just x ->
            Ok x


{-| A field that must match the given regex.
-}
matches : Regex -> e -> Validator e String String
matches expression err str =
    case str of
        Nothing ->
            Err err

        Just s ->
            if Regex.contains expression s then
                Ok s
            else
                Err err


{-| A basic email regex. This is incredibly simplistic, but is
included for convenience.

Remember that the only real way to validate an email address is to
send something to it and get a reply.
-}
email : e -> Validator e String String
email =
    matches emailRegex


{-| -}
emailRegex : Regex
emailRegex =
    caseInsensitive (regex "^\\S+@\\S+\\.\\S+$")
