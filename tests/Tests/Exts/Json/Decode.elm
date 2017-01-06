module Tests.Exts.Json.Decode exposing (tests)

import Expect exposing (..)
import Exts.Json.Decode exposing (..)
import Json.Decode exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Json.Decode"
        [ stringIgnoringBlanksTests ]


stringIgnoringBlanksTests : Test
stringIgnoringBlanksTests =
    let
        nameDecoder =
            (field "name" stringIgnoringBlanks)
    in
        describe "stringIgnoringBlanks" <|
            List.map (test "" << always)
                [ assertDecodes nameDecoder "{\"name\": \"kris\"}" (Just "kris")
                , assertDecodes nameDecoder "{\"name\": \"\"}" Nothing
                , assertDecodes nameDecoder "{\"name\": \"   \"}" Nothing
                , assertDecodes nameDecoder "{\"name\": null}" Nothing
                ]


assertDecodes : Decoder a -> String -> a -> Expectation
assertDecodes decoder string expected =
    equal (Ok expected)
        (decodeString decoder string)
