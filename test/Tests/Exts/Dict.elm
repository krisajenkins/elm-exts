module Tests.Exts.Dict
  (tests)
  where

import ElmTest exposing (..)
import Exts.Dict exposing (..)
import Dict

tests : Test
tests = suite "Exts.Dict" [getWithDefaultTests]

animals : Dict.Dict String String
animals = Dict.fromList [ ("Tom", "cat"), ("Jerry", "mouse") ]

getWithDefaultTests : Test
getWithDefaultTests =
  ElmTest.suite "getWithDefault"
    [defaultTest <| assertEqual (getWithDefault "def" "Tom" animals) "cat"
    ,defaultTest <| assertEqual (getWithDefault "def" "Mickey" animals) "def"]
