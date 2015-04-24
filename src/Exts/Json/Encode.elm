module Exts.Json.Encode where

{-| Extensions to the core Json Encode library. |-}

import Json.Encode exposing (..)
import Set as Set exposing (Set)

set : (comparable -> Value) -> Set comparable -> Value
set encodeElement = list << List.map encodeElement << List.sort << Set.toList
