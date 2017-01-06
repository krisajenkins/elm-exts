module Tests.Exts.Validation exposing (tests)

import Expect exposing (..)
import Exts.Result exposing (..)
import Exts.Validation exposing (..)
import Regex exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Validation"
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
        |> List.map (test "" << always)
        |> describe "email"


assertEmail : String -> Expectation
assertEmail str =
    true "" (isOk (email "Not an email." (Just str)))


assertNotEmail : String -> Expectation
assertNotEmail str =
    true "" (isErr (email "Not an email." (Just str)))


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
    describe "full form" <|
        List.map (test "" << always)
            [ equal (Err "Age is required")
                (validateForm
                    { message = Just "Hello"
                    , email = Just "test@asdf.com"
                    , firstName = Just "Kris"
                    , age = Nothing
                    }
                )
            ]
