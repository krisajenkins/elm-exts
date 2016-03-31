module Exts.Effects (asEffect, noFx) where

{-| Extensions to the `Effects` library.

@docs asEffect, noFx

-}

import Effects exposing (Effects)
import Result exposing (Result)
import Task exposing (Task)


{-| Turn a `Task` into a `Result` effect.
-}
asEffect : Task e a -> Effects (Result e a)
asEffect =
  Effects.task << Task.toResult


{-| Wrap a plain model as a `(model, no-effects)` pair.

This is taken from the [Effects Documentation](http://package.elm-lang.org/packages/evancz/elm-effects/1.0.0/Effects),
which rightly suggests it might be useful!
-}
noFx : m -> ( m, Effects a )
noFx model =
  ( model, Effects.none )
