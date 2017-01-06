module Tests.Exts.Array exposing (tests)

import Array exposing (..)
import Expect exposing (..)
import Exts.Array exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Array"
        [ updateTests
        , deleteTests
        , unzipTests
        , singletonTests
        ]


updateTests : Test
updateTests =
    let
        anArray =
            Array.fromList (List.range 1 4)
    in
        describe "update" <|
            List.map (test "" << always)
                [ equal anArray
                    (update -1 ((*) 2) anArray)
                , equal (Array.fromList [ 1, 2, 6, 4 ])
                    (update 2 ((*) 2) anArray)
                , equal anArray
                    (update 5 ((*) 2) anArray)
                ]


deleteTests : Test
deleteTests =
    let
        anArray =
            Array.fromList (List.range 1 4)
    in
        describe "delete" <|
            List.map (test "" << always)
                [ equal anArray
                    (delete -1 anArray)
                , equal (Array.fromList (List.range 2 4))
                    (delete 0 anArray)
                , equal (Array.fromList [ 1, 2, 4 ])
                    (delete 2 anArray)
                , equal anArray
                    (delete 4 anArray)
                ]


unzipTests : Test
unzipTests =
    describe "unzip" <|
        List.map (test "" << always)
            [ equal ( Array.empty, Array.empty )
                (unzip Array.empty)
            , equal
                ( Array.fromList [ 1 ]
                , Array.fromList [ "a" ]
                )
                (unzip (Array.fromList [ ( 1, "a" ) ]))
            , equal
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


{-| I find it quite fun that this is the only test you need to make,
given the type signature. Parametricity can be mind-blowing...
-}
singletonTests : Test
singletonTests =
    describe "singleton" <|
        List.map (test "" << always)
            [ equal (empty |> push ())
                (singleton ())
            ]
