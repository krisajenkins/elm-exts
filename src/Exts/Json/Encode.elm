module Exts.Json.Encode where

{-| Extensions to the core Json Encode library. |-}

import Json.Encode (..)
import List
import Set
import Set (Set)

set : (comparable -> Value) -> Set comparable -> Value
set encodeElement = list << List.map encodeElement << List.sort << Set.toList
