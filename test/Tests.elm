module Tests where

import Graphics.Element exposing (Element)
import ElmTest.Test exposing (test, Test, suite, defaultTest)
import ElmTest.Runner.Element exposing (runDisplay)
import Tests.Exts.Delta
import Tests.Exts.List

tests : Test
tests = suite "All" [Tests.Exts.Delta.tests
                    ,Tests.Exts.List.tests]

main : Element
main = runDisplay tests
