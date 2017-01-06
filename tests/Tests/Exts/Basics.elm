module Tests.Exts.Basics exposing (tests)

import Expect exposing (..)
import Exts.Basics exposing (..)
import Fuzz exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Basics"
        [ compareByTests
          -- , maxByTests
          -- , minByTests
        ]


type alias Wrapper a =
    { value : a }


compareByTests : Test
compareByTests =
    describe "compareBy"
        [ fuzz2 int
            int
            "Comparing two ints gives the same result as wrapping them and comparing them by an unwrapping function."
            (\n1 n2 ->
                equal (compareBy .value (Wrapper n1) (Wrapper n2))
                    (compare n1 n2)
            )
        ]


maxByTests : Test
maxByTests =
    describe "maxBy"
        [ test "" <| always <| equal (Wrapper 5) (maxBy .value (Wrapper 0) (Wrapper 5))
        , fuzz2 int
            int
            "The max of two ints is the same as wrapping them and taking the maxBy an unwrapping function."
            (\n1 n2 ->
                equal (maxBy .value (Wrapper n1) (Wrapper n2))
                    (Wrapper (max n1 n2))
            )
        ]


minByTests : Test
minByTests =
    describe "minBy"
        [ fuzz2 int
            int
            "The min of two ints is the same as wrapping them and taking the minBy an unwrapping function."
            (\n1 n2 ->
                equal (minBy .value (Wrapper n1) (Wrapper n2))
                    (Wrapper (min n1 n2))
            )
        ]
