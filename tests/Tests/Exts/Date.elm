module Tests.Exts.Date exposing (tests)

import Date exposing (..)
import Expect exposing (..)
import Exts.Date exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Date"
        [ toISOStringTests
        ]


toISOStringTests : Test
toISOStringTests =
    let
        check ( from, to ) =
            test from
                (always
                    (equal
                        (Date.fromString from
                            |> Result.map toISOString
                        )
                        (Ok to)
                    )
                )
    in
        describe "toIsoString" <|
            List.map check
                [ ( "Tue Oct 20 2015 17:01:01", "2015-10-20T17:01:01.000Z" )
                , ( "Wed Oct 21 2015 01:00:00", "2015-10-21T01:00:00.000Z" )
                , ( "Wed Oct 21 2015 03:00:00", "2015-10-21T03:00:00.000Z" )
                , ( "Wed Jun 21 2015 03:00:00", "2015-6-21T03:00:00.000Z" )
                , ( "Sun Sep 18 2016 00:00:00 GMT-0700", "2016-9-18T08:00:00.000Z" )
                , ( "Sun Sep 18 2016 00:00:00 GMT-0100", "2016-9-18T02:00:00.000Z" )
                ]


toRFC3339Tests : Test
toRFC3339Tests =
    let
        check ( from, to ) =
            test from
                (always
                    (equal
                        (Date.fromString from
                            |> Result.map toRFC3339
                        )
                        (Ok to)
                    )
                )
    in
        describe "toRFC3339" <|
            List.map check
                [ ( "Tue Oct 20 2015 17:01:01", "2015-10-20" )
                , ( "Mon Apr 03 2015 12:34:56", "2015-04-03" )
                ]
