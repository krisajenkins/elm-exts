module Exts.Http exposing (put, postContent, postForm, postJson, handleError, cgiParameters)

{-| Extensions to the `Http` library.

@docs handleError
@docs put
@docs postContent
@docs postForm
@docs postJson
@docs cgiParameters
-}

import Http exposing (..)
import Json.Decode exposing (Decoder)
import String
import Task exposing (Task, andThen, mapError, succeed, fail)


promoteError : RawError -> Error
promoteError rawError =
    case rawError of
        RawTimeout ->
            Timeout

        RawNetworkError ->
            NetworkError


checkStatus : Response -> Task Error Response
checkStatus response =
    if 200 <= response.status && response.status < 300 then
        Task.succeed response
    else
        Task.fail (BadResponse response.status response.statusText)


{-| Lift a raw Http response into a `Task Error Response`, using the same rules `Http` uses internally.
-}
handleError : Task RawError Response -> Task Error Response
handleError t =
    andThen (Task.mapError promoteError t)
        checkStatus


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


{-| Send a `POST` request with appropriate headers for form payloads.
-}
postForm : Decoder value -> String -> Body -> Task Error value
postForm =
    postContent "application/x-www-form-urlencoded"


{-| Send a `POST` request with appropriate headers JSON payloads.
-}
postJson : Decoder value -> String -> Body -> Task Error value
postJson =
    postContent "application/json"


{-| Encode a CGI parameter pair.
-}
cgiParameter : ( String, String ) -> String
cgiParameter ( key, value ) =
    uriEncode key ++ "=" ++ uriEncode value


{-| Encode a CGI parameter list.
-}
cgiParameters : List ( String, String ) -> String
cgiParameters =
    List.map cgiParameter
        >> String.join "&"
