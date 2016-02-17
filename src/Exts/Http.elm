module Exts.Http (put, postForm, promoteError) where

{-| Extensions to the main Http library.

@docs promoteError, put, postForm
-}

import Http exposing (..)
import Json.Decode exposing (Decoder)
import Task exposing (Task, andThen, mapError, succeed, fail)


{-| Convert an `Http.RawError` into an `Error`, using the same rules `Http` uses internally.
-}
promoteError : RawError -> Error
promoteError rawError =
  case rawError of
    RawTimeout ->
      Timeout

    RawNetworkError ->
      NetworkError


{-| Send a simple `PUT` request.
-}
put : Decoder value -> String -> Http.Body -> Task Error value
put decoder url body =
  let
    request =
      { verb = "PUT"
      , headers = []
      , url = url
      , body = body
      }
  in
    fromJson decoder (send Http.defaultSettings request)


{-| Send a `POST` request with appropriate headers form-encoding.
-}
postForm : Decoder value -> String -> Body -> Task Error value
postForm decoder url body =
  let
    request =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/x-www-form-urlencoded" ) ]
      , url = url
      , body = body
      }
  in
    fromJson decoder (Http.send Http.defaultSettings request)
