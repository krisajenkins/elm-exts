module Tests.Exts.List exposing (tests)

import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import ElmTest exposing (..)
import Exts.List exposing (..)
import Set


tests : Test
tests =
    ElmTest.suite "Exts.List"
        [ chunkTests
        , evidenceToTest (quickCheck chunkClaims)
        , mergeByTests
        , firstMatchTests
        , evidenceToTest (quickCheck firstMatchClaims)
        , uniqueTests
        , singletonTests
        , evidenceToTest (quickCheck maximumByClaims)
        , evidenceToTest (quickCheck minimumByClaims)
        ]


chunkTests : Test
chunkTests =
    [ assertEqual [ [] ]
        (chunk 0 [])
    , assertEqual []
        (chunk 3 [])
    , assertEqual ([ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 10 ] ])
        (chunk 3 [1..10])
    , assertEqual ([ [1..4], [5..8], [9..12] ])
        (chunk 4 [1..12])
    ]
        |> List.map defaultTest
        |> ElmTest.suite "chunk"


chunkClaims : Claim
chunkClaims =
    Check.suite "chunk"
        [ claim "Concat restores the list."
            `that` (\( n, xs ) -> List.concat (chunk n xs))
            `is` (\( n, xs ) -> xs)
            `for` (tuple ( int, list char ))
        , claim "Every chunk but the last should be <n> items long."
            `that` (\( n, xs ) ->
                        chunk n xs
                            |> List.reverse
                            |> List.tail
                            |> Maybe.withDefault []
                            |> List.map List.length
                            |> Set.fromList
                            |> Set.insert n
                   )
            `is` (\( n, xs ) -> Set.singleton n)
            `for` (tuple ( int, list char ))
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
        [ assertEqual []
            (mergeBy .id [] [])
        , assertEqual [ t1, t2a ]
            (mergeBy .id
                [ t1, t2a ]
                []
            )
        , assertEqual [ t1, t2a ]
            (mergeBy .id
                []
                [ t1, t2a ]
            )
        , assertEqual [ t1, t2b ]
            (mergeBy .id
                [ t1, t2a, t2b ]
                []
            )
        , assertEqual [ t1, t2b ]
            (mergeBy .id
                [ t1, t2a ]
                [ t2b ]
            )
        , assertEqual [ t1, t2a ]
            (mergeBy .id
                [ t2b ]
                [ t1, t2a ]
            )
        ]
            |> List.map defaultTest
            |> ElmTest.suite "mergeBy"


firstMatchTests : Test
firstMatchTests =
    ElmTest.suite "firstMatch"
        [ defaultTest (assertEqual Nothing (firstMatch (always True) []))
        , defaultTest (assertEqual (Just 6) (firstMatch ((<) 5) [1..10]))
        , defaultTest (assertEqual Nothing (firstMatch ((<) 20) [1..10]))
        ]


isEven : Int -> Bool
isEven n =
    n % 2 == 0


firstMatchClaims : Claim
firstMatchClaims =
    Check.suite "firstMatch"
        [ claim "An always-false predicate is the same as Nothing."
            `that` firstMatch (always False)
            `is` (always Nothing)
            `for` list int
        , claim "An always-true predicate is the same as List.head."
            `that` firstMatch (always True)
            `is` List.head
            `for` list int
        , claim "An always-false predicate is the same as Nothing."
            `that` firstMatch isEven
            `is` (List.head << List.filter isEven)
            `for` list int
        ]


uniqueTests : Test
uniqueTests =
    [ assertEqual [] (unique [])
    , assertEqual [ 1, 3, 2, 4 ] (unique [ 1, 3, 2, 4, 1, 2, 3, 4 ])
    ]
        |> List.map defaultTest
        |> ElmTest.suite "unique"


{-| I find it quite fun that this is the only test you need to make,
given the type signature. Parametricity can be mind-blowing...
-}
singletonTests : Test
singletonTests =
    ElmTest.suite "singleton"
        [ defaultTest
            (assertEqual [ () ]
                (singleton ())
            )
        ]


type alias Wrapper a =
    { value : a }


maximumByClaims : Claim
maximumByClaims =
    Check.suite "maximumBy"
        [ claim "The maximum of a list of ints is the same as wrapping them and taking the maximumBy an unwrapping function."
            `that` (\xs -> maximumBy .value (List.map Wrapper xs))
            `is` (\xs -> Maybe.map Wrapper (List.maximum xs))
            `for` (list int)
        ]


minimumByClaims : Claim
minimumByClaims =
    Check.suite "minimumBy"
        [ claim "The minimum of a list of ints is the same as wrapping them and taking the minimumBy an unwrapping function."
            `that` (\xs -> minimumBy .value (List.map Wrapper xs))
            `is` (\xs -> Maybe.map Wrapper (List.minimum xs))
            `for` (list int)
        ]
