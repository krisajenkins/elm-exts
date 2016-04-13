module Exts.State (subUpdate) where

{-| Extensions to the core `Array` library.

@docs subUpdate
-}

import Effects exposing (Effects)
import Focus exposing (Focus, get, set)


{-| Quite often in Elm we want to say:

  - This `action` wraps a sub-module's `subaction`.
  - Take that `subaction`, apply the sub-module's update function to get `(submodel,subeffects)`
  - Merge the `submodel` our `model`.
  - Merge the `subeffects` into our `effects`, using a wrapper.

That plumbing's pretty repetitive, and we can abstract it out if we
create a Focus to package up the getting & setting.

For example, if you want to pass actions down the chain to a `DatePicker`:


    -- Create a Focus. This may well be useful in other parts of your code.
    datePickerFocus : Focus Model DatePicker.Model
    datePickerFocus =
      Focus.create
        .datePicker
        (\f model -> { model | datePicker = f model.datePicker })

    -- Handle the sub-update in one sweep.
    update action model =
      case action of
        ...
        DatePickerAction subaction ->
          subUpdate
            DatePicker.update
            datePickerFocus
            DatePickerAction
            subaction
            model
        ...
-}
subUpdate : (subaction -> submodel -> ( submodel, Effects subaction )) -> Focus model submodel -> (subaction -> action) -> subaction -> model -> ( model, Effects action )
subUpdate subModuleUpdate subModelFocus actionWrapper subaction model =
  let
    ( newSubmodel, newSubeffects ) =
      subModuleUpdate subaction (get subModelFocus model)
  in
    ( set subModelFocus newSubmodel model
    , Effects.map actionWrapper newSubeffects
    )
