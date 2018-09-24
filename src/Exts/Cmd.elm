module Exts.Cmd exposing (later, perform)

{-| Extensions to the core `Cmd` library.

@docs later
@docs perform
-}

import Exts.Task exposing (delay)
import Task exposing (Task)
import Time exposing (Time)


later : Time -> a -> Cmd a
later t value =
    Task.succeed value
        |> delay t
        |> Task.perform identity identity


{-| Thanks to `elm-community/basics-extra`! It's not worth adding a
dependency for this one function, but full credit to them for the
idea.
-}
never : Never -> a
never =
    never


perform : Task Never a -> Cmd a
perform =
    Task.perform never identity
