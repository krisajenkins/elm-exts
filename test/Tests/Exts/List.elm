module Tests.Exts.List (tests) where

import ElmTest exposing (..)
import Exts.List exposing (..)
import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import Set


tests : Test
tests =
  ElmTest.suite
    "Exts.List"
    [ chunkTests
    , evidenceToTest (quickCheck chunkClaims)
    , mergeByTests
    , firstMatchTests
    , evidenceToTest (quickCheck firstMatchClaims)
    ]


chunkTests : Test
chunkTests =
  ElmTest.suite
    "chunk"
    [ defaultTest
        (assertEqual
          [ [] ]
          (chunk 0 [])
        )
    , defaultTest
        (assertEqual
          []
          (chunk 3 [])
        )
    , defaultTest
        (assertEqual
          ([ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 10 ] ])
          (chunk 3 [1..10])
        )
    , defaultTest
        (assertEqual
          ([ [1..4], [5..8], [9..12] ])
          (chunk 4 [1..12])
        )
    ]


chunkClaims : Claim
chunkClaims =
  Check.suite
    "chunk"
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
    ElmTest.suite
      "mergeBy"
      [ defaultTest
          (assertEqual
            []
            (mergeBy .id [] [])
          )
      , defaultTest
          (assertEqual
            [ t1, t2a ]
            (mergeBy
              .id
              [ t1, t2a ]
              []
            )
          )
      , defaultTest
          (assertEqual
            [ t1, t2a ]
            (mergeBy
              .id
              []
              [ t1, t2a ]
            )
          )
      , defaultTest
          (assertEqual
            [ t1, t2b ]
            (mergeBy
              .id
              [ t1, t2a, t2b ]
              []
            )
          )
      , defaultTest
          (assertEqual
            [ t1, t2b ]
            (mergeBy
              .id
              [ t1, t2a ]
              [ t2b ]
            )
          )
      , defaultTest
          (assertEqual
            [ t1, t2a ]
            (mergeBy
              .id
              [ t2b ]
              [ t1, t2a ]
            )
          )
      ]


firstMatchTests : Test
firstMatchTests =
  ElmTest.suite
    "firstMatch"
    [ defaultTest (assertEqual Nothing (firstMatch (always True) []))
    ]


isEven : Int -> Bool
isEven n =
  n % 2 == 0


firstMatchClaims : Claim
firstMatchClaims =
  Check.suite
    "firstMatch"
    [ claim
        "An always-false predicate is the same as Nothing."
        `that` firstMatch (always False)
        `is` (always Nothing)
        `for` list int
    , claim "An always-true predicate is the same as List.head."
        `that` firstMatch (always True)
        `is` List.head
        `for` list int
    , claim
        "An always-false predicate is the same as Nothing."
        `that` firstMatch isEven
        `is` (List.head << List.filter isEven)
        `for` list int
    ]
