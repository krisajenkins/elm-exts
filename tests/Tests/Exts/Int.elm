module Tests.Exts.Int exposing (tests)

import Expect exposing (..)
import Exts.Int exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Int"
        [ floorByTests
        ]


floorByTests : Test
floorByTests =
    describe "floorBy" <|
        List.map (test "" << always)
            [ equal Nothing (floorBy 0 143)
            , equal (Just 142) (floorBy 2 143)
            , equal (Just 100) (floorBy 50 143)
            ]
