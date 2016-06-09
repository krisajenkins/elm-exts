module Tests.Exts.Json.Decode exposing (tests)

import ElmTest exposing (..)
import Exts.Json.Decode exposing (..)
import Json.Decode exposing (..)


tests : Test
tests =
    ElmTest.suite "Exts.Json.Decode"
        [ stringIgnoringBlanksTests
        ]


stringIgnoringBlanksTests : Test
stringIgnoringBlanksTests =
    let
        nameDecoder =
            ("name" := stringIgnoringBlanks)
    in
        [ assertDecodes nameDecoder "{\"name\": \"kris\"}" (Just "kris")
        , assertDecodes nameDecoder "{\"name\": \"\"}" Nothing
        , assertDecodes nameDecoder "{\"name\": \"   \"}" Nothing
        , assertDecodes nameDecoder "{\"name\": null}" Nothing
        ]
            |> List.map defaultTest
            |> ElmTest.suite "stringIgnoringBlanks"


assertDecodes : Decoder a -> String -> a -> Assertion
assertDecodes decoder string expected =
    assertEqual (Ok expected)
        (decodeString decoder string)
