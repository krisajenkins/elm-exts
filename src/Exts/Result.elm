module Exts.Result where

{-| Extensions to the core Maybe library. |-}

import Http

isOk : Result a b -> Bool
isOk x =
  case x of
    Ok _ -> True
    Err _ -> False

resultToMaybe : Result a b -> Maybe b
resultToMaybe x =
  case x of
    Err _ -> Nothing
    Ok y -> Just y

resultWithDefault : b -> Result a b ->  b
resultWithDefault d x =
  case x of
    Ok y -> y
    Err _ -> d
