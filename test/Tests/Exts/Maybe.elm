module Tests.Exts.Maybe exposing (tests)

import ElmTest exposing (..)
import Exts.Maybe exposing (..)


tests : Test
tests =
  ElmTest.suite "Exts.Maybe"
    [ joinTests ]


joinTests : Test
joinTests =
  [ assertEqual (Just 5)
      (join (+) (Just 2) (Just 3))
  , assertEqual Nothing
      (join (+) Nothing (Just 5))
  , assertEqual Nothing
      (join (+) (Just 5) Nothing)
  , assertEqual Nothing
      (join (+) Nothing Nothing)
  , assertEqual (Just 6)
      (List.foldl (join (+)) (Just 0) [ Just 1, Just 2, Just 3 ])
  , assertEqual Nothing
      (List.foldl (join (+)) (Just 0) [ Just 1, Nothing, Just 2, Just 3 ])
  ]
    |> List.map defaultTest
    |> ElmTest.suite "join"
