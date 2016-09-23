port module Main exposing (..)

import Json.Encode exposing (Value)
import Test.Runner.Node exposing (run)
import Tests


main : Program Value
main =
    run emit Tests.tests


port emit : ( String, Value ) -> Cmd msg
