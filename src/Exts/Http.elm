module Exts.Http
    exposing
        ( cgiParameters
        , formBody
        )

{-| Extensions to the `Http` library.

@docs cgiParameters
@docs formBody
-}

import Http exposing (..)
import String


{-| Encode a CGI parameter pair.
-}
cgiParameter : ( String, String ) -> String
cgiParameter ( key, value ) =
    encodeUri key ++ "=" ++ encodeUri value


{-| Encode a CGI parameter list.
-}
cgiParameters : List ( String, String ) -> String
cgiParameters =
    List.map cgiParameter
        >> String.join "&"


{-| Put some key-value pairs in the body of your `Request`. This will automatically
add the `Content-Type: application/x-www-form-urlencoded` header.
-}
formBody : List ( String, String ) -> Body
formBody =
    cgiParameters
        >> stringBody "application/x-www-form-urlencoded"
