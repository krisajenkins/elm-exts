module Tests.Exts.Date exposing (tests)

import Date exposing (..)
import ElmTest exposing (..)
import Exts.Date exposing (..)


tests : Test
tests =
    suite "Exts.Date"
        [ toISOStringTests
        ]


toISOStringTests : Test
toISOStringTests =
    let
        check ( from, to ) =
            defaultTest
                <| assertEqual (Ok to)
                <| Result.map toISOString
                <| Date.fromString from
    in
        ElmTest.suite "toIsoString"
            <| List.map check
                [ ( "Tue Oct 20 2015 17:01:01", "2015-10-20T16:01:01.000Z" )
                , ( "Wed Oct 21 2015 01:00:00", "2015-10-21T00:00:00.000Z" )
                ]
