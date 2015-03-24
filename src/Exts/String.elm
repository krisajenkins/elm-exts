module Exts.String where

import String (..)

removePrefix : String -> String -> String
removePrefix prefix s =
  if (startsWith prefix s)
    then dropLeft (length prefix) s
    else s
