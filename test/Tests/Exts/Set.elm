module Tests.Exts.Set exposing (tests)

import ElmTest exposing (..)
import Set exposing (..)
import Exts.Set exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Set"
        [ uniqueItemsTests
        , toggleTests
        ]


uniqueItemsTests : Test
uniqueItemsTests =
    suite "uniqueItems"
        [ defaultTest
            (assertEqualSets (Set.fromList [ 18, 21 ])
                (uniqueItems (.age)
                    [ { age = Just 18 }
                    , { age = Just 21 }
                    , { age = Nothing }
                    , { age = Just 21 }
                    , { age = Just 18 }
                    ]
                )
            )
        ]


toggleTests : Test
toggleTests =
    [ assertEqualSets (Set.fromList [ "A", "B", "C" ])
        (toggle "A" (Set.fromList [ "B", "C" ]))
    , assertEqualSets (Set.fromList [ "C" ])
        (toggle "B" (Set.fromList [ "B", "C" ]))
    ]
        |> List.map defaultTest
        |> suite "toggle"


assertEqualSets : Set comparable -> Set comparable -> Assertion
assertEqualSets xs ys =
    assertEqual (Set.toList xs)
        (Set.toList ys)
