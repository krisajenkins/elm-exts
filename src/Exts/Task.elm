module Exts.Task exposing (delay)

{-| Extensions to the core `Process` library.

@docs delay
-}

import Process exposing (..)
import Task exposing (..)
import Time exposing (Time)


{-| Delay running the `Task` for a given `Time`.

This is just the example given in `Task.sleep` wrapped up, because it's o useful.
-}
delay : Time -> Task e a -> Task e a
delay time task =
    sleep time `andThen` (\_ -> task)
