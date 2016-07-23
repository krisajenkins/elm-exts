module Tests.Exts.Validation exposing (tests)

import ElmTest exposing (..)
import Exts.Result exposing (..)
import Exts.Validation exposing (..)
import Regex exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Validation"
        [ emailTests
        , fullFormTests
        ]


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


type alias Form =
    { message : Maybe String
    , email : Maybe String
    , firstName : Maybe String
    , age : Maybe Int
    }


type alias ValidForm =
    { message : String
    , email : String
    , firstName : String
    , age : Int
    }


validateForm : Form -> Result String ValidForm
validateForm form =
    Ok ValidForm
        |: notBlank "Message is required and may not be blank." form.message
        |: email "Email is required and may not be blank." form.email
        |: matches (caseInsensitive (regex "^[a-z]+$")) "First name may only contain letters." form.firstName
        |: required "Age is required" form.age


fullFormTests : Test
fullFormTests =
    ElmTest.suite "full form"
        <| List.map defaultTest
            [ assertEqual (Err "Age is required")
                (validateForm
                    { message = Just "Hello"
                    , email = Just "test@asdf.com"
                    , firstName = Just "Kris"
                    , age = Nothing
                    }
                )
            ]
