module Exts.Http (put, postContent, postForm, postJson, promoteError) where

{-| Extensions to the main Http library.

@docs promoteError, put, postContent, postForm, postJson
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


{-| Send a `POST` request with the given content-type.
-}
postContent : String -> Decoder value -> String -> Body -> Task Error value
postContent contentType decoder url body =
  let
    request =
      { verb = "POST"
      , headers = [ ( "Content-Type", contentType ) ]
      , url = url
      , body = body
      }
  in
    fromJson decoder (Http.send Http.defaultSettings request)


{-| Send a `POST` request with appropriate headers form-encoding.
-}
postForm : Decoder value -> String -> Body -> Task Error value
postForm =
  postContent "application/x-www-form-urlencoded"


{-| Send a `POST` request with appropriate headers form-encoding.
-}
postJson : Decoder value -> String -> Body -> Task Error value
postJson =
  postContent "application/json"
