module Tests.Exts.Date (tests) where

import ElmTest exposing (..)
import Exts.Date exposing (..)
import Date exposing (..)


tests : Test
tests =
  suite "Exts.Date" [ toISOStringTests ]


toISOStringTests : Test
toISOStringTests =
  ElmTest.suite
    "toIsoString"
    [ defaultTest
        (assertEqual
          (Ok "2015-10-20T16:01:01.000Z")
          (Result.map toISOString (Date.fromString "Tue Oct 20 2015 17:01:01"))
        )
    , defaultTest
        (assertEqual
          (Ok "2015-10-21T00:00:00.000Z")
          (Result.map toISOString (Date.fromString "Wed Oct 21 2015 01:00:00"))
        )
    ]
