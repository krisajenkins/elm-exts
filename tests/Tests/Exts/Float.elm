module Tests.Exts.Float exposing (tests)

import Expect exposing (..)
import Exts.Float exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Float"
        [ roundToTests ]


roundToTests : Test
roundToTests =
    let
        check ( expected, places, value ) =
            test "" <|
                always <|
                    equal expected
                        (roundTo places value)
    in
        describe "roundTo" <|
            List.map check
                [ ( 1235, 0, 1234.56 )
                , ( 1234.0, 1, 1234 )
                , ( 1234.0, 2, 1234.0 )
                , ( 0.0, 2, 0 )
                , ( 0, 0, 0 )
                , ( 1234.57, 2, 1234.567 )
                , ( 1234.567, 6, 1234.567 )
                , ( -1235, 0, -1234.56 )
                , ( -1234.0, 1, -1234 )
                , ( -1234.57, 2, -1234.567 )
                , ( -1234.567, 6, -1234.567 )
                , ( 100.0, 1, 99.99 )
                , ( 2.0, 1, 1.95 )
                , ( 5.18, 2, 5.175 )
                , ( 0.014, 3, 0.0135 )
                , ( 7.1316, 4, 7.13155 )
                , ( 0.12, 2, 0.123 )
                , ( -0.12, 2, -0.123 )
                , ( 0.0, 2, 0 )
                , ( 0.0, 2, 0 )
                , ( -0.46, 2, -0.46 )
                , ( -0.99, 2, -0.99 )
                , ( -1.46, 2, -1.46 )
                , ( -1.0, 2, -0.999 )
                , ( -2.46, 2, -2.46 )
                , ( -3.0, 2, -2.999 )
                ]
