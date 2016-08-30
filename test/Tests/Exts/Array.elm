module Tests.Exts.Array exposing (tests)

import Array exposing (..)
import ElmTest exposing (..)
import Exts.Array exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Array"
        [ updateTests
        , unzipTests
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


unzipTests : Test
unzipTests =
    suite "unzip"
        <| List.map defaultTest
            [ assertEqual ( Array.empty, Array.empty )
                (unzip Array.empty)
            , assertEqual
                ( Array.fromList [ 1 ]
                , Array.fromList [ "a" ]
                )
                (unzip (Array.fromList [ ( 1, "a" ) ]))
            , assertEqual
                ( Array.fromList [ 1, 2, 3 ]
                , Array.fromList [ "a", "b", "c" ]
                )
                (unzip
                    (Array.fromList
                        [ ( 1, "a" )
                        , ( 2, "b" )
                        , ( 3, "c" )
                        ]
                    )
                )
            ]
