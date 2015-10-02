module Tests.Exts.List
  (tests)
  where

import ElmTest.Test exposing (test, Test, suite, defaultTest)
import ElmTest.Assertion exposing (assert, assertEqual)
import Exts.List exposing (..)

tests : Test
tests = suite "Exts.List" [mergeByTests]

mergeByTests : Test
mergeByTests =
  let t1  = {id = 1, name = "One"}
      t2a = {id = 2, name = "Two"}
      t2b = {id = 2, name = "Three!"}
  in
  suite "mergeBy"
    [defaultTest (assertEqual []
                              (mergeBy .id [] []))
    ,defaultTest (assertEqual [t1, t2a]
                              (mergeBy .id [t1, t2a]
                                           []))
    ,defaultTest (assertEqual [t1, t2a]
                              (mergeBy .id []
                                           [t1, t2a]
                                           ))
    ,defaultTest (assertEqual [t1, t2b]
                              (mergeBy .id [t1, t2a, t2b]
                                           []))
    ,defaultTest (assertEqual [t1, t2b]
                              (mergeBy .id [t1, t2a]
                                           [t2b]))
    ,defaultTest (assertEqual [t1, t2a]
                              (mergeBy .id [t2b]
                                           [t1, t2a]))]
