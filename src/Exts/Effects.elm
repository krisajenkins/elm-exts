module Exts.Effects (..) where

{-| Extensions for Effects.

@docs fromTask, fromValue,addEffects
-}

import Effects exposing (Effects, batch)
import Task exposing (Task)


{-| Convert a `Task` to an `Effect` which conveys success or failure.

-}
fromTask : Task e a -> Effects (Result e a)
fromTask =
  Task.toResult >> Effects.task


{-| Convert a value to an `Effect`.

-}
fromValue : a -> Effects a
fromValue =
  Task.succeed >> Effects.task


{-| Convenience function that's like `Effects.batch`, but just for two elements.

-}
addEffects : Effects a -> Effects a -> Effects a
addEffects e1 e2 =
  batch [ e1, e2 ]
