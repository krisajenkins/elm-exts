module Exts.Task exposing
    ( delay
    , asCmd
    )

{-| Extensions to the core `Process` library.

@docs delay
@docs asCmd

-}

import Process exposing (..)
import Task exposing (..)


{-| Delay running the `Task` for a given `Time`.
-}
delay : Float -> Task e a -> Task e a
delay time task =
    sleep time
        |> andThen (always task)


{-| Turn a `Task` into a `Cmd` which returns a `Result`.
-}
asCmd : Task e a -> Cmd (Result e a)
asCmd =
    Task.attempt identity
