module Tests where

import ElmTest.Test exposing (test, Test, suite, defaultTest)
import ElmTest.Runner.Element exposing (runDisplay)
import Tests.Exts.Date
import Tests.Exts.Delta
import Tests.Exts.List
import Html exposing (Html,div)
import Check exposing (Claim, quickCheck)
import Check.Runner.Browser exposing (display)

tests : Test
tests =
  suite "All" [Tests.Exts.Date.tests
              ,Tests.Exts.Delta.tests
              ,Tests.Exts.List.tests]

claims : Claim
claims =
  Check.suite "All"
              [Tests.Exts.List.claims]

main : Html
main = div []
           [runDisplay tests |> Html.fromElement
           ,quickCheck claims |> display]
