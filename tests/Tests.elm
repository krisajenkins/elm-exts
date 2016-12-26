module Tests exposing (..)

import Test exposing (..)
import Tests.Exts.Array
import Tests.Exts.Basics
import Tests.Exts.Date
import Tests.Exts.Delta
import Tests.Exts.Dict
import Tests.Exts.Float
import Tests.Exts.Int
import Tests.Exts.Json.Decode
import Tests.Exts.List
import Tests.Exts.Maybe
import Tests.Exts.Result
import Tests.Exts.Set
import Tests.Exts.String
import Tests.Exts.Validation


tests : Test
tests =
    describe "All"
        [ Tests.Exts.Array.tests
        , Tests.Exts.Basics.tests
        , Tests.Exts.Date.tests
        , Tests.Exts.Delta.tests
        , Tests.Exts.Dict.tests
        , Tests.Exts.Float.tests
        , Tests.Exts.Int.tests
        , Tests.Exts.Json.Decode.tests
        , Tests.Exts.List.tests
        , Tests.Exts.Maybe.tests
        , Tests.Exts.Result.tests
        , Tests.Exts.Set.tests
        , Tests.Exts.String.tests
        , Tests.Exts.Validation.tests
        ]
