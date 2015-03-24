module Exts.String where

{-| Extensions to the core String library. |-}

import String (..)

removePrefix : String -> String -> String
removePrefix prefix s =
  if (startsWith prefix s)
    then dropLeft (length prefix) s
    else s
