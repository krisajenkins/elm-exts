module Main (..) where

import Console
import Task exposing (Task)
import ElmTest exposing (..)
import Tests.Exts.Date
import Tests.Exts.Delta
import Tests.Exts.Dict
import Tests.Exts.List


tests : Test
tests =
  suite
    "All"
    [ Tests.Exts.Date.tests
    , Tests.Exts.Delta.tests
    , Tests.Exts.List.tests
    , Tests.Exts.Dict.tests
    ]


port runner : Signal (Task x ())
port runner =
  Console.run (consoleRunner tests)
