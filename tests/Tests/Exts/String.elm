module Tests.Exts.String exposing (tests)

import Expect exposing (..)
import Exts.String exposing (..)
import Fuzz exposing (..)
import String
import Test exposing (..)


tests : Test
tests =
    describe "Exts.String"
        [ removePrefixTests ]


validIndex : Int -> String -> Bool
validIndex n s =
    n
        >= 0
        && n
        < String.length s


removePrefixTests : Test
removePrefixTests =
    describe "removePrefix"
        [ test "" <| always <| equal "elm" (removePrefix "cr" "crelm")
        , test "" <| always <| equal "mouthwash" (removePrefix "cr" "mouthwash")
        , fuzz
            (Fuzz.map
                (\( n, s ) ->
                    if String.isEmpty s then
                        ( 0, s )
                    else
                        ( n % String.length s, s )
                )
                (tuple ( int, string ))
            )
            "String length is preserved."
            (\( n, s ) ->
                equal (String.dropLeft n s)
                    (removePrefix (String.slice 0 n s) s)
            )
        ]
