module Exts.Http where

import List
import Set
import Set (Set)
import Http

isWaiting : Http.Response a -> Bool
isWaiting response =
  case response of
    Http.Waiting -> True
    _            -> False

isSuccess : Http.Response a -> Bool
isSuccess response =
  case response of
    Http.Success _ -> True
    _              -> False
