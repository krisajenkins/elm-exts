module Tests.Exts.Dict exposing (tests)

import Dict
import Expect exposing (..)
import Exts.Dict exposing (..)
import Fuzz exposing (..)
import String
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Dict"
        [ getWithDefaultTests
        , foldToListTests
        ]


animals : Dict.Dict String String
animals =
    Dict.fromList [ ( "Tom", "cat" ), ( "Jerry", "mouse" ) ]


getWithDefaultTests : Test
getWithDefaultTests =
    describe "getWithDefault" <|
        List.map (test "" << always)
            [ equal "cat" (getWithDefault "def" "Tom" animals)
            , equal "def" (getWithDefault "def" "Mickey" animals)
            ]


foldToListTests : Test
foldToListTests =
    describe "foldToList"
        [ fuzz
            (Fuzz.map Dict.fromList
                (list
                    (tuple
                        ( intRange 0 1000
                        , string
                        )
                    )
                )
            )
            "foldToList is equivalent to flattening the list and mapping the function."
            (\dict ->
                equal (foldToList String.repeat dict)
                    (List.map (uncurry String.repeat) (Dict.toList dict))
            )
        ]
