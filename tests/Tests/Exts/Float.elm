module Tests.Exts.Float exposing (tests)

import Expect
import Exts.Float exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "test sig figs function" <|
        let
            testPairs =
                [ ( 3, 1111.1, 1110.0 )
                , ( 1, 0.02342, 0.02 )
                , ( 2, 2.2704234, 2.3 )
                , ( 2, 20000, 20000 )
                , ( 2, 201, 200 )
                , ( 4, 0, 0 )
                , ( 3, -12312.453, -12300 )
                ]

            expected =
                List.map
                    (\( sigFigs, val, expected ) ->
                        expected
                    )
                    testPairs

            funcResults =
                List.map
                    (\( sigFigs, val, expected ) ->
                        toSigFigs sigFigs val
                    )
                    testPairs
        in
            [ test "results match expected" <|
                \() ->
                    Expect.equal
                        expected
                        funcResults
            ]
