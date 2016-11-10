module Exts.Task exposing (delay, asCmd)

{-| Extensions to the core `Process` library.

@docs delay
@docs asCmd
-}

import Process exposing (..)
import Task exposing (..)
import Time exposing (Time)


{-| Delay running the `Task` for a given `Time`.

This is just the example given in `Task.sleep` wrapped up, because it's o useful.
-}
delay : Time -> Task e a -> Task e a
delay time task =
    (sleep time)
        |> andThen (always task)


{-| Turn a `Task` into a `Cmd` which returns a `Result`.
-}
asCmd : Task e a -> Cmd (Result e a)
asCmd =
    Task.attempt identity
