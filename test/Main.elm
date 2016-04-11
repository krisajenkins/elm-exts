module Main (..) where

import Console
import ElmTest exposing (..)
import Task exposing (Task)
import Tests.Exts.Array
import Tests.Exts.Date
import Tests.Exts.Delta
import Tests.Exts.Dict
import Tests.Exts.List
import Tests.Exts.Result
import Tests.Exts.String


tests : Test
tests =
  suite
    "All"
    [ Tests.Exts.Date.tests
    , Tests.Exts.Delta.tests
    , Tests.Exts.Dict.tests
    , Tests.Exts.List.tests
    , Tests.Exts.Result.tests
    , Tests.Exts.String.tests
    , Tests.Exts.Array.tests
    ]


port runner : Signal (Task x ())
port runner =
  Console.run (consoleRunner tests)
