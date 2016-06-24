module Tests.Exts.Date exposing (tests)

import ElmTest exposing (..)
import Exts.Date exposing (..)
import Date exposing (..)


tests : Test
tests =
    suite "Exts.Date" [ toISOStringTests, toRFC3339Tests ]


toISOStringTests : Test
toISOStringTests =
    ElmTest.suite "toIsoString"
        [ defaultTest
            (assertEqual (Ok "2015-10-20T16:01:01.000Z")
                (Result.map toISOString (Date.fromString "Tue Oct 20 2015 17:01:01"))
            )
        , defaultTest
            (assertEqual (Ok "2015-10-21T00:00:00.000Z")
                (Result.map toISOString (Date.fromString "Wed Oct 21 2015 01:00:00"))
            )
        ]


toRFC3339Tests : Test
toRFC3339Tests =
    ElmTest.suite "toRFC3339"
        [ defaultTest
            (assertEqual (Ok "2015-10-20")
                (Result.map toRFC3339 (Date.fromString "Tue Oct 20 2015 17:01:01"))
            )
        ]
