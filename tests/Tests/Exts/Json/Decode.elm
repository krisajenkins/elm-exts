module Tests.Exts.Json.Decode exposing (tests)

import Expect exposing (..)
import Exts.Json.Decode exposing (..)
import Json.Decode as Json exposing (..)
import Test exposing (..)
import Time


tests : Test
tests =
    describe "Exts.Json.Decode"
        [ stringIgnoringBlanksTests
        , decodeTimeTests
        ]


stringIgnoringBlanksTests : Test
stringIgnoringBlanksTests =
    let
        nameDecoder =
            field "name" stringIgnoringBlanks
    in
    describe "stringIgnoringBlanks" <|
        List.indexedMap (\n -> test (String.fromInt n) << always)
            [ assertDecodes nameDecoder "{\"name\": \"kris\"}" (Just "kris")
            , assertDecodes nameDecoder "{\"name\": \"\"}" Nothing
            , assertDecodes nameDecoder "{\"name\": \"   \"}" Nothing
            , assertDecodes nameDecoder "{\"name\": null}" Nothing
            ]


decodeTimeTests : Test
decodeTimeTests =
    let
        nameDecoder =
            field "name" decodeTime
    in
    describe "decodeTime" <|
        List.indexedMap (\n -> test (String.fromInt n) << always)
            [ assertDecodes (decodeTime |> Json.map (Time.toDay Time.utc)) "1537798418988" 24
            ]


assertDecodes : Decoder a -> String -> a -> Expectation
assertDecodes decoder string expected =
    equal (Ok expected)
        (decodeString decoder string)
