module Exts.Task (..) where

{-| Extensions for Tasks.

@docs asEffect
-}

import Effects exposing (Effects)
import Task exposing (Task)


{-| Convert a `Task` to an `Effect` which conveys success or failure.
-}
asEffect : Task e a -> Effects (Result e a)
asEffect =
  Effects.task << Task.toResult
