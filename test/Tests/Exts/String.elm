module Tests.Exts.String (tests) where

import ElmTest exposing (..)
import Exts.String exposing (..)
import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test
import String


tests : Test
tests =
  ElmTest.suite
    "Exts.String"
    [ removePrefixTests
    ]


validIndex : Int -> String -> Bool
validIndex n s =
  n
    >= 0
    && n
    < String.length s


removePrefixTests : Test
removePrefixTests =
  ElmTest.suite
    "removePrefix"
    [ ElmTest.defaultTest (assertEqual "elm" (removePrefix "cr" "crelm"))
    , ElmTest.defaultTest (assertEqual "mouthwash" (removePrefix "cr" "mouthwash"))
    , Check.Test.evidenceToTest (Check.quickCheck removePrefixClaims)
    ]


removePrefixClaims : Claim
removePrefixClaims =
  Check.suite
    "removePrefix"
    [ claim "String length is preserved."
        `that` (\( n, s ) -> String.dropLeft n s)
        `is` (\( n, s ) -> removePrefix (String.slice 0 n s) s)
        `for` (filter
                (uncurry validIndex)
                (tuple ( int, string ))
              )
    ]
