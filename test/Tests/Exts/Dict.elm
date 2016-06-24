module Tests.Exts.Dict exposing (tests)

import Check exposing (..)
import Check.Producer as Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import Dict
import ElmTest exposing (..)
import Exts.Dict exposing (..)
import String


tests : Test
tests =
    ElmTest.suite "Exts.Dict"
        [ getWithDefaultTests
        , evidenceToTest (quickCheck foldToListClaims)
        ]


animals : Dict.Dict String String
animals =
    Dict.fromList [ ( "Tom", "cat" ), ( "Jerry", "mouse" ) ]


getWithDefaultTests : Test
getWithDefaultTests =
    ElmTest.suite "getWithDefault"
        <| List.map defaultTest
            [ assertEqual "cat" (getWithDefault "def" "Tom" animals)
            , assertEqual "def" (getWithDefault "def" "Mickey" animals)
            ]


foldToListClaims : Claim
foldToListClaims =
    Check.suite "foldToList"
        [ claim "foldToList is equivalent to flattening the list and mapping the function."
            `that` foldToList String.repeat
            `is` (\dict -> List.map (uncurry String.repeat) (Dict.toList dict))
            `for` Producer.map Dict.fromList
                    (list
                        (tuple
                            ( (filter ((>) 1000) int)
                            , string
                            )
                        )
                    )
        ]
