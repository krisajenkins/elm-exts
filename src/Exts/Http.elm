module Exts.Http exposing (cgiParameters)

{-| Extensions to the `Http` library.

@docs cgiParameters
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
