module Exts.Effects
  (asEffect)
  where

{-| Extensions to the Effects library.

@docs asEffect

-}

import Effects exposing (Effects)
import Result exposing (Result)
import Task exposing (Task)

{-| Turn a Task into a Result Effect. -}
asEffect : Task e a -> Effects (Result e a)
asEffect = Effects.task << Task.toResult
