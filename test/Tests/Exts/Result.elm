module Tests.Exts.Result exposing (tests)

import ElmTest exposing (..)
import Exts.Result exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Result"
        [ fromOkTests
        , fromErrTests
        ]


fromOkTests : Test
fromOkTests =
    ElmTest.suite "fromOk"
        <| List.map defaultTest
            [ assertEqual (Just 5) (fromOk (Ok 5))
            , assertEqual Nothing (fromOk (Err 5))
            ]


fromErrTests : Test
fromErrTests =
    ElmTest.suite "fromErr"
        <| List.map defaultTest
            [ assertEqual (Just 5) (fromErr (Err 5))
            , assertEqual Nothing (fromErr (Ok 5))
            ]
