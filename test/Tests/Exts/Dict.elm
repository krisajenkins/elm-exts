module Tests.Exts.Dict (tests) where

import ElmTest exposing (..)
import Exts.Dict exposing (..)
import Dict
import Check exposing (..)
import Check.Producer as Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import String


tests : Test
tests =
  ElmTest.suite
    "Exts.Dict"
    [ getWithDefaultTests
    , evidenceToTest (quickCheck foldToListClaims)
    ]


animals : Dict.Dict String String
animals =
  Dict.fromList [ ( "Tom", "cat" ), ( "Jerry", "mouse" ) ]


getWithDefaultTests : Test
getWithDefaultTests =
  ElmTest.suite
    "getWithDefault"
    [ defaultTest <| assertEqual (getWithDefault "def" "Tom" animals) "cat"
    , defaultTest <| assertEqual (getWithDefault "def" "Mickey" animals) "def"
    ]


foldToListClaims : Claim
foldToListClaims =
  Check.suite
    "foldToList"
    [ claim "foldToList is equivalent to flattening the list and mapping the function."
        `that` foldToList String.repeat
        `is` (\dict -> List.map (uncurry String.repeat) (Dict.toList dict))
        `for` Producer.map
                Dict.fromList
                (list
                  (tuple
                    ( (filter ((>) 1000) int)
                    , string
                    )
                  )
                )
    ]
