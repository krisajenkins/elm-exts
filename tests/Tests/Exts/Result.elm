module Tests.Exts.Result exposing (tests)

import Expect exposing (..)
import Exts.Result exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Result"
        [ fromOkTests
        , fromErrTests
        ]


fromOkTests : Test
fromOkTests =
    describe "fromOk" <|
        List.map (test "" << always)
            [ equal (Just 5) (fromOk (Ok 5))
            , equal Nothing (fromOk (Err 5))
            ]


fromErrTests : Test
fromErrTests =
    describe "fromErr" <|
        List.map (test "" << always)
            [ equal (Just 5) (fromErr (Err 5))
            , equal Nothing (fromErr (Ok 5))
            ]
