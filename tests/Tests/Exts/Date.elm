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
            test ""
                <| always
                <| equal (Ok to)
                <| Result.map toISOString
                <| Date.fromString from
    in
        describe "toIsoString"
            <| List.map check
                [ ( "Tue Oct 20 2015 17:01:01", "2015-10-20T16:01:01.000Z" )
                , ( "Wed Oct 21 2015 01:00:00", "2015-10-21T00:00:00.000Z" )
                , ( "Wed Oct 21 2015 03:00:00", "2015-10-21T02:00:00.000Z" )
                ]


toRFC3339Tests : Test
toRFC3339Tests =
    let
        check ( from, to ) =
            test ""
                <| always
                <| equal (Ok to)
                <| Result.map toRFC3339
                <| Date.fromString from
    in
        describe "toRFC3339"
            <| List.map check
                [ ( "Tue Oct 20 2015 17:01:01", "2015-10-20" )
                , ( "Mon Apr 03 2015 12:34:56", "2015-04-03" )
                ]
