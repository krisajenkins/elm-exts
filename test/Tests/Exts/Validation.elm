module Tests.Exts.Validation exposing (tests)

import ElmTest exposing (..)
import Exts.Result exposing (..)
import Exts.Validation exposing (..)


tests : Test
tests =
  ElmTest.suite "Exts.Validation"
    [ emailTests ]


emailTests : Test
emailTests =
  [ assertEmail "asdf@asdf.com"
  , assertEmail "test-user@test.co.uk"
  , assertNotEmail "THINGS"
  , assertNotEmail "  !\test-user@test.co.uk \x01"
  ]
    |> List.map defaultTest
    |> ElmTest.suite "email"


assertEmail : String -> Assertion
assertEmail str =
  assert (isOk (email "Not an email." (Just str)))


assertNotEmail : String -> Assertion
assertNotEmail str =
  assert (isErr (email "Not an email." (Just str)))
