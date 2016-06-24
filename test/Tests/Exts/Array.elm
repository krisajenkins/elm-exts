module Tests.Exts.Array exposing (tests)

import Array exposing (..)
import ElmTest exposing (..)
import Exts.Array exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Array"
        [ updateTests
        ]


updateTests : Test
updateTests =
    let
        anArray =
            Array.fromList [ 1, 2, 3, 4 ]
    in
        ElmTest.suite "update"
            <| List.map defaultTest
                [ assertEqual anArray
                    (update -1 ((*) 2) anArray)
                , assertEqual (Array.fromList [ 1, 2, 6, 4 ])
                    (update 2 ((*) 2) anArray)
                , assertEqual anArray
                    (update 5 ((*) 2) anArray)
                ]
