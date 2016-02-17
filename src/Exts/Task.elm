module Exts.Task (..) where

{-| Extensions for Tasks.

@docs asEffect
-}

import Effects exposing (Effects)
import Task exposing (Task)


{-| Convert a `Task` to an `Effect` which conveys success or failure.
-}
asEffect : Task a b -> Effects (Result a b)
asEffect =
  Effects.task << Task.toResult
