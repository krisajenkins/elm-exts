module Exts.Monocle exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import Exts.Tuple
import Monocle.Lens as Lens exposing (Lens)
import Monocle.Optional as Optional exposing (Optional)


type alias Response model msg =
    ( model, Cmd msg )


model : Lens (Response model msg) model
model =
    first


cmd : Lens (Response model msg) (Cmd msg)
cmd =
    second


update :
    Optional model submodel
    -> (submodel -> Response submodel submsg)
    -> model
    -> Response model submsg
update optional updater model =
    case optional.getOption model of
        Nothing ->
            ( model, Cmd.none )

        Just v ->
            Exts.Tuple.first (flip optional.set model)
                (updater v)
