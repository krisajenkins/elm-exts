module Tests.Exts.Delta exposing (tests)

import Expect exposing (..)
import Exts.Delta exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Exts.Delta" [ generationTests ]


generationTests : Test
generationTests =
    describe "generation" <|
        List.map (test "" << always)
            [ equal { empty | entering = [ 1, 2 ] }
                (generation [ 1, 2 ] empty)
            , equal
                { empty
                    | entering = [ 3, 4 ]
                    , continuing = [ 2 ]
                    , leaving = [ 1 ]
                }
                (generation [ 2, 3, 4 ]
                    { empty | entering = [ 1, 2 ] }
                )
            , equal
                { empty
                    | entering = [ 6, 7, 8, 9, 10 ]
                    , continuing = [ 1, 2, 3, 4, 5 ]
                    , leaving = []
                }
                (generation [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
                    { empty
                        | entering = [ 1, 2 ]
                        , continuing = [ 3, 4, 5 ]
                        , leaving = [ 6, 7 ]
                    }
                )
            , equal
                { empty
                    | entering = [ 6.0, 7.0, 8.0, 9.0, 10.0 ]
                    , continuing = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
                    , leaving = []
                }
                (generation [ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0 ]
                    { empty
                        | entering = [ 1.0, 2.0 ]
                        , continuing = [ 3.0, 4.0, 5.0 ]
                        , leaving = [ 6.0, 7.0 ]
                    }
                )
            , equal
                { empty
                    | entering = [ { a = 1 } ]
                    , continuing = [ { a = 2 } ]
                    , leaving = [ { a = 3 } ]
                }
                (generation [ { a = 1 }, { a = 2 } ]
                    { empty
                        | entering = [ { a = 2 } ]
                        , continuing = [ { a = 3 } ]
                        , leaving = []
                    }
                )
            ]
