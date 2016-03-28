module Tests.Exts.Int (tests) where

import ElmTest exposing (..)
import Exts.Int exposing (..)


tests : Test
tests =
  ElmTest.suite
    "Exts.Int"
    [ floorByTests
    ]


floorByTests : Test
floorByTests =
  ElmTest.suite
    "floorBy"
    [ defaultTest
        (assertEqual
          Nothing
          (floorBy 0 143)
        )
    , defaultTest
        (assertEqual
          (Just 142)
          (floorBy 2 143)
        )
    , defaultTest
        (assertEqual
          (Just 100)
          (floorBy 50 143)
        )
    ]
