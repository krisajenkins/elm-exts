module Tests.Exts.Date
  (tests)
  where

import ElmTest.Test exposing (test, Test, suite, defaultTest)
import ElmTest.Assertion exposing (assert, assertEqual)
import Exts.Date exposing (..)
import Date exposing (..)

tests : Test
tests = suite "Exts.Date" [toISOStringTests]

toISOStringTests : Test
toISOStringTests =
  suite "toIsoString"
    [defaultTest (assertEqual "2015-10-20T16:01:01.125Z"
                              (toISOString (Date.fromTime 1445356861125)))
    ,defaultTest (assertEqual "2015-10-20T00:00:00.585Z"
                              (toISOString (Date.fromTime 1445299200585)))]
