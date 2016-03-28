module Tests.Exts.Array (tests) where

import ElmTest exposing (..)
import Array exposing (..)
import Exts.Array exposing (..)


tests : Test
tests =
  ElmTest.suite
    "Exts.Array"
    [ updateTests
    ]


updateTests : Test
updateTests =
  let
    anArray =
      Array.fromList [ 1, 2, 3, 4 ]
  in
    ElmTest.suite
      "update"
      [ defaultTest
          (assertEqual
            anArray
            (update -1 ((*) 2) anArray)
          )
      , defaultTest
          (assertEqual
            (Array.fromList [ 1, 2, 6, 4 ])
            (update 2 ((*) 2) anArray)
          )
      , defaultTest
          (assertEqual
            anArray
            (update 5 ((*) 2) anArray)
          )
      ]
