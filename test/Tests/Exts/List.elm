module Tests.Exts.List (tests) where

import ElmTest exposing (..)
import Exts.List exposing (..)
import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test
import Set


tests : Test
tests =
  ElmTest.suite
    "Exts.List"
    [ chunkTests
    , mergeByTests
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
    , Check.Test.evidenceToTest (Check.quickCheck chunkClaims)
    ]


chunkClaims : Claim
chunkClaims =
  Check.suite
    "chunk"
    [ claim "Concat restores the list."
        `true` (\( n, xs ) -> (List.concat (chunk n xs)) == xs)
        `for` (tuple ( int, list char ))
    , claim "Every chunk but the last should be <n> items long."
        `true` (\( n, xs ) ->
                  (chunk n xs
                    |> List.reverse
                    |> List.tail
                    |> Maybe.withDefault []
                    |> List.map List.length
                    |> Set.fromList
                    |> Set.insert n
                  )
                    == Set.singleton n
               )
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
