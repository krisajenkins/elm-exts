module Tests.Exts.Set exposing (tests)

import Expect exposing (..)
import Exts.Set exposing (..)
import Set exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Set"
        [ uniqueItemsTests
        , toggleTests
        ]


uniqueItemsTests : Test
uniqueItemsTests =
    describe "uniqueItems"
        [ test "" <|
            always <|
                equalSets (Set.fromList [ 18, 21 ])
                    (uniqueItems (.age)
                        [ { age = Just 18 }
                        , { age = Just 21 }
                        , { age = Nothing }
                        , { age = Just 21 }
                        , { age = Just 18 }
                        ]
                    )
        ]


toggleTests : Test
toggleTests =
    describe "toggle" <|
        List.map (test "" << always)
            [ equalSets (Set.fromList [ "A", "B", "C" ])
                (toggle "A" (Set.fromList [ "B", "C" ]))
            , equalSets (Set.fromList [ "C" ])
                (toggle "B" (Set.fromList [ "B", "C" ]))
            ]


equalSets : Set comparable -> Set comparable -> Expectation
equalSets xs ys =
    equal (Set.toList xs)
        (Set.toList ys)
