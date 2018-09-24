module Tests.Exts.Maybe exposing (tests)

import Expect exposing (..)
import Exts.Maybe exposing (..)
import Fuzz exposing (int, list)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Maybe"
        [ joinTests
        , validateTests
        , matchesTests
        , mappendTests
        , oneOfTests
        ]


checkEqual n ( expected, actual ) =
    test (String.fromInt n) (\_ -> equal expected actual)


joinTests : Test
joinTests =
    describe "join" <|
        List.indexedMap checkEqual
            [ ( Just 5
              , join (+) (Just 2) (Just 3)
              )
            , ( Nothing
              , join (+) Nothing (Just 5)
              )
            , ( Nothing
              , join (+) (Just 5) Nothing
              )
            , ( Nothing
              , join (+) Nothing Nothing
              )
            , ( Just 6
              , List.foldl (join (+)) (Just 0) [ Just 1, Just 2, Just 3 ]
              )
            , ( Nothing
              , List.foldl (join (+)) (Just 0) [ Just 1, Nothing, Just 2, Just 3 ]
              )
            ]


isEven : Int -> Bool
isEven n =
    remainderBy 2 n == 0


validateTests : Test
validateTests =
    describe "validate" <|
        List.indexedMap checkEqual
            [ ( Just 2, validate isEven 2 )
            , ( Nothing, validate isEven 3 )
            ]


matchesTests : Test
matchesTests =
    describe "matches" <|
        List.indexedMap checkEqual
            [ ( Just 2, matches isEven (Just 2) )
            , ( Nothing, matches isEven (Just 3) )
            , ( Nothing, matches isEven Nothing )
            ]


oneOfTests : Test
oneOfTests =
    describe "oneOf"
        [ fuzz (list (Fuzz.maybe int))
            "oneOf is equivalent to filtering out the Nothings from a list, and taking the head."
            (\maybeXs ->
                Expect.equal (oneOf maybeXs)
                    (maybeXs
                        |> List.filterMap identity
                        |> List.head
                    )
            )
        ]


mappendTests : Test
mappendTests =
    describe "mappend" <|
        List.indexedMap checkEqual
            [ ( Nothing
              , mappend Nothing Nothing
              )
            , ( Nothing
              , mappend Nothing (Just 3)
              )
            , ( Nothing
              , mappend (Just 2) Nothing
              )
            , ( Just ( 2, 3 )
              , mappend (Just 2) (Just 3)
              )
            ]
