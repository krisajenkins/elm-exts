module Tests.Exts.List exposing (tests)

import Expect exposing (..)
import Exts.List exposing (..)
import Fuzz exposing (..)
import Set
import Test exposing (..)


tests : Test
tests =
    describe "Exts.List"
        [ chunkTests
        , mergeByTests
        , firstMatchTests
        , uniqueTests
        , singletonTests
        , maximumByTests
        , minimumByTests
        , unfoldTests
        ]


chunkTests : Test
chunkTests =
    describe "chunk"
        [ test "" <|
            always <|
                equal [ [] ]
                    (chunk 0 [])
        , test "" <|
            always <|
                equal []
                    (chunk 3 [])
        , test "" <|
            always <|
                equal ([ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 10 ] ])
                    (chunk 3 (List.range 1 10))
        , test "" <|
            always <|
                equal
                    ([ (List.range 1 4)
                     , (List.range 5 8)
                     , (List.range 9 12)
                     ]
                    )
                    (chunk 4 (List.range 1 12))
        , fuzz2 int
            (list char)
            "Concat restores the list."
            (\n xs ->
                equal (List.concat (chunk n xs))
                    xs
            )
        , fuzz2 int
            (list char)
            "Every chunk but the last should be <n> items long."
            (\n xs ->
                equal
                    (chunk n xs
                        |> List.reverse
                        |> List.tail
                        |> Maybe.withDefault []
                        |> List.map List.length
                        |> Set.fromList
                        |> Set.insert n
                    )
                    (Set.singleton n)
            )
        ]


mergeByTests : Test
mergeByTests =
    let
        t1 =
            { id = 1, name = "One" }

        t2a =
            { id = 2, name = "Two" }

        t2b =
            { id = 2, name = "Three!" }
    in
        describe "mergeBy"
            [ test "" <|
                always <|
                    equal []
                        (mergeBy .id [] [])
            , test "" <|
                always <|
                    equal [ t1, t2a ]
                        (mergeBy .id
                            [ t1, t2a ]
                            []
                        )
            , test "" <|
                always <|
                    equal [ t1, t2a ]
                        (mergeBy .id
                            []
                            [ t1, t2a ]
                        )
            , test "" <|
                always <|
                    equal [ t1, t2b ]
                        (mergeBy .id
                            [ t1, t2a, t2b ]
                            []
                        )
            , test "" <|
                always <|
                    equal [ t1, t2b ]
                        (mergeBy .id
                            [ t1, t2a ]
                            [ t2b ]
                        )
            , test "" <|
                always <|
                    equal [ t1, t2a ]
                        (mergeBy .id
                            [ t2b ]
                            [ t1, t2a ]
                        )
            ]


firstMatchTests : Test
firstMatchTests =
    describe "firstMatch"
        [ test "" <| always <| equal Nothing (firstMatch (always True) [])
        , fuzz (list int)
            "An always-false predicate is the same as Nothing."
            (\items ->
                equal (firstMatch (always False) items)
                    Nothing
            )
        , fuzz (list int)
            "An always-true predicate is the same as List.head."
            (\items ->
                equal (firstMatch (always True) items)
                    (List.head items)
            )
        , fuzz (list int)
            "firstMatch is equivalent to a filter plus head."
            (\items ->
                equal (firstMatch isEven items)
                    (List.head <| List.filter isEven items)
            )
        ]


isEven : Int -> Bool
isEven n =
    n % 2 == 0


uniqueTests : Test
uniqueTests =
    describe "unique"
        [ test "" <| always <| equal [] (unique [])
        , test "" <| always <| equal [ 1, 3, 2, 4 ] (unique [ 1, 3, 2, 4, 1, 2, 3, 4 ])
        ]


{-| I find it quite fun that this is the only test you need to make,
given the type signature. Parametricity can be mind-blowing...
-}
singletonTests : Test
singletonTests =
    describe "singleton"
        [ test "" <|
            always <|
                equal [ () ] (singleton ())
        ]


type alias Wrapper a =
    { value : a }


maximumByTests : Test
maximumByTests =
    describe "maximumBy"
        [ fuzz (list int)
            "The maximum of a list of ints is the same as wrapping them and taking the maximumBy an unwrapping function."
            (\xs ->
                equal (Maybe.map Wrapper (List.maximum xs))
                    (maximumBy .value (List.map Wrapper xs))
            )
        ]


minimumByTests : Test
minimumByTests =
    describe "minimumBy"
        [ fuzz (list int)
            "The minimum of a list of ints is the same as wrapping them and taking the minimumBy an unwrapping function."
            (\xs ->
                equal (Maybe.map Wrapper (List.minimum xs))
                    (minimumBy .value (List.map Wrapper xs))
            )
        ]


unfoldTests : Test
unfoldTests =
    describe "unfold"
        [ test "Unfolding an int range." <|
            always <|
                equal (List.range 0 9)
                    (unfold
                        (\n ->
                            if n < 10 then
                                Just ( n + 1, n )
                            else
                                Nothing
                        )
                        0
                    )
        , test "Unfolding an int range, but trying to blow the stack." <|
            always <|
                equal (List.range 0 9999)
                    (unfold
                        (\n ->
                            if n < 10000 then
                                Just ( n + 1, n )
                            else
                                Nothing
                        )
                        0
                    )
        ]
