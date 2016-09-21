module Tests.Exts.Basics exposing (tests)

import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import ElmTest exposing (..)
import Exts.Basics exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Basics"
        [ evidenceToTest (quickCheck compareByClaims)
        , maxByTests
        , evidenceToTest (quickCheck maxByClaims)
        , evidenceToTest (quickCheck minByClaims)
        ]


type alias Wrapper a =
    { value : a }


compareByClaims : Claim
compareByClaims =
    Check.suite "compareBy"
        [ claim "Comparing two ints gives the same result as wrapping them and comparing them by an unwrapping function."
            `that` (\( n1, n2 ) -> compareBy .value (Wrapper n1) (Wrapper n2))
            `is` (\( n1, n2 ) -> compare n1 n2)
            `for` (tuple ( int, int ))
        ]


maxByTests : Test
maxByTests =
    ElmTest.suite "maxBy"
        <| List.map defaultTest
            [ assertEqual (Wrapper 5) (maxBy .value (Wrapper 0) (Wrapper 5)) ]


maxByClaims : Claim
maxByClaims =
    Check.suite "maxBy"
        [ claim "The max of two ints is the same as wrapping them and taking the maxBy an unwrapping function."
            `that` (\( n1, n2 ) -> maxBy .value (Wrapper n1) (Wrapper n2))
            `is` (\( n1, n2 ) -> Wrapper (max n1 n2))
            `for` (tuple ( int, int ))
        ]


minByClaims : Claim
minByClaims =
    Check.suite "minBy"
        [ claim "The min of two ints is the same as wrapping them and taking the minBy an unwrapping function."
            `that` (\( n1, n2 ) -> minBy .value (Wrapper n1) (Wrapper n2))
            `is` (\( n1, n2 ) -> Wrapper (min n1 n2))
            `for` (tuple ( int, int ))
        ]
