module Exts.Validation (..) where

{-| Simple tools for validation. See also [Richard Feldman's elm-validate](http://package.elm-lang.org/packages/rtfeldman/elm-validate/latest)

@docs apply, (|:), required, notBlank, emailRegex
-}

import Regex exposing (Regex, caseInsensitive, regex, contains)
import Result exposing (andThen, map)


{-| A validator is a function that takes a possibly-invalid form, and
either returns an error message, or a form that is definitely valid. For example:

    type alias Form =
      { email : Maybe String
      , age : Maybe Int
      }

    type alias ValidForm =
      { email : String
      , age : Int
      }

    validateForm : Form -> Result String ValidForm
    validateForm form =
      Ok ValidForm
        |: (notBlank "Email is required and may not be blank." form.email)
        |: (required "Age is required" form.age)

An error message is typically a `String`, but may be any type you choose.

(Hat tip to CircuitHub, who inspired the syntax and guided the code with their [elm-json-extra](http://package.elm-lang.org/packages/circuithub/elm-json-extra/latest) library.)
-}
apply : Result e (a -> b) -> Result e a -> Result e b
apply f aResult =
  f `andThen` (\f' -> f' `map` aResult)


{-| Convenient synonym for `apply`.
-}
(|:) : Result e (a -> b) -> Result e a -> Result e b
(|:) =
  apply


{-| A field that might be `Nothing`, but is only valid if it is `Just a`.
-}
required : e -> Maybe a -> Result e a
required err =
  Maybe.withDefault (Err err) << Maybe.map Ok


{-| A field that might be `Nothing`, but is only valid if it is a non-empty `String`.
-}
notBlank : e -> Maybe String -> Result e String
notBlank err str =
  case str of
    Nothing ->
      Err err

    Just "" ->
      Err err

    Just x ->
      Ok x


{-| A basic email regex. This is incredibly simplistic, but is
included for convenience.

Remember that the only real way to validate an email address is to
send something to it and get a reply.
-}
emailRegex : Regex
emailRegex =
  caseInsensitive (regex ".+@.+\\..+")
