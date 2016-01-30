module Tests where

import ElmTest exposing (test, Test, suite, defaultTest, elementRunner)
import Tests.Exts.Date
import Tests.Exts.Delta
import Tests.Exts.Dict
import Tests.Exts.List
import Html exposing (..)
import Html.Attributes exposing (style)
import Check exposing (Claim,quickCheck,Evidence(..),FailureOptions,SuccessOptions)

tests : Test
tests =
  suite "All" [Tests.Exts.Date.tests
              ,Tests.Exts.Delta.tests
              ,Tests.Exts.List.tests
              ,Tests.Exts.Dict.tests]

claims : Claim
claims =
  Check.suite "All"
              [Tests.Exts.List.claims]

main : Html
main = div []
           [h2 [] [text "Unit Tests"]
           ,elementRunner tests |> Html.fromElement
           ,h2 [] [text "Property Tests"]
           ,quickCheck claims |> displayEvidence]

------------------------------------------------------------

displayFailure : FailureOptions -> Html
displayFailure failure =
  table [style [("color", "red")]]
        [thead []
               [tr []
                   [th [] [text "Name"]
                   ,th [] [text "Expected"]
                   ,th [] [text "Actual"]
                   ,th [] [text "Counterexample"]]]
        ,tbody []
               [tr []
                   [td [] [text failure.name]
                   ,td [] [text failure.expected]
                   ,td [] [text failure.actual]
                   ,td [] [text failure.counterExample]]]]

displaySuccess : SuccessOptions -> Html
displaySuccess success =
  table [style [("color", "green")]]
        [thead []
               [tr []
                   [th [] [text "Name"]
                   ,th [] [text "Checks"]]]
        ,tbody []
               [tr []
                   [td [] [text success.name]
                   ,td [] [text (toString success.numberOfChecks)]]]]


displayEvidence : Evidence -> Html
displayEvidence evidence =
  case evidence of
    Multiple title children -> div [style [("margin-left", "20px")]]
                                   (h4 [] [text title]::(List.map displayEvidence children))
    Unit (Err error) -> displayFailure error
    Unit (Ok result) -> displaySuccess result
