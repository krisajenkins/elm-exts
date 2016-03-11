module Tests.Exts.Result (tests) where

import ElmTest exposing (..)
import Exts.Result exposing (..)


tests : Test
tests =
  ElmTest.suite
    "Exts.Result"
    [ fromOkTests
    , fromErrTests
    ]


fromOkTests : Test
fromOkTests =
  ElmTest.suite
    "fromOk"
    [ defaultTest (assertEqual (Just 5) (fromOk (Ok 5)))
    , defaultTest (assertEqual Nothing (fromOk (Err 5)))
    ]


fromErrTests : Test
fromErrTests =
  ElmTest.suite
    "fromErr"
    [ defaultTest (assertEqual (Just 5) (fromErr (Err 5)))
    , defaultTest (assertEqual Nothing (fromErr (Ok 5)))
    ]
