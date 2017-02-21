module Tests.Exts.Result exposing (tests)

import Expect exposing (..)
import Exts.Result exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Result"
        [ fromOkTests
        , fromErrTests
        , mappendTests
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


mappendTests : Test
mappendTests =
    describe "mappend" <|
        List.map (test "" << always)
            [ equal (Err "A")
                (mappend (Err "A") (Err "B"))
            , equal (Err "A")
                (mappend (Err "A") (Ok 3))
            , equal (Err "B")
                (mappend (Ok 2) (Err "B"))
            , equal (Ok ( 2, 3 ))
                (mappend (Ok 2) (Ok 3))
            ]
