module Exts.StartApp (updateSeparately) where

{-| Extensions to StartApp.

@docs updateSeparately
-}

import Effects exposing (Effects)


{-| StartApp apps supply an update function of:

    update : Action -> Model -> ( Model, Effects a)

As apps grow larger, and more nested, this complection of `Model` and
`Effects` results becomes a real pain to manage. The wiring for
calling a sub-component's `update` function, upacking the result pair,
and re-packing into your own result pair, is very tedious.

Things become much cleaner if we split the effects out. First, we retype `update` as:

    update : Action -> Model -> Model
    update action model = ...

...then we supply a separate `effects` function of:

    effects : Action -> ( Model, Model ) -> Effects Action
    effects action (oldModel, newModel) = ...

(Often your `effects` function will just use `newModel`, but you may
need access to the model before `update` was called.)

This separation of concerns cleans up each function, reduces wiring
and makes testing a bit easier too.

To use it, split your functions as above, then in your `StartApp.start` call use:

    import Exts.StartApp exposing (updateSeparately)
    app : App Model
    app =
      StartApp.start
        { ...
        , update = updateSeparately update effects
        , ...
        }
-}
updateSeparately : (a -> m -> m) -> (a -> ( m, m ) -> Effects a) -> a -> m -> ( m, Effects a )
updateSeparately update effects action oldModel =
  let
    newModel =
      update action oldModel

    newEffects =
      effects action ( oldModel, newModel )
  in
    ( newModel
    , newEffects
    )
