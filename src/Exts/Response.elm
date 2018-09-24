module Exts.Return exposing (addCmd, mapLens, mapOptional, mapOptionalWithFeedback, withFeedback)

import Monocle.Lens exposing (..)
import Monocle.Optional exposing (..)
import Response exposing (..)


mapLens :
    Lens model submodel
    -> (submodel -> Response submodel submsg)
    -> model
    -> Response model submsg
mapLens lens =
    mapOptional (fromLens lens)


mapOptional :
    Optional model submodel
    -> (submodel -> Response submodel submsg)
    -> model
    -> Response model submsg
mapOptional optional updateFn model =
    case optional.getOption model of
        Nothing ->
            ( model, Cmd.none )

        Just submodel ->
            mapModel (\newValue -> optional.set newValue model)
                (updateFn submodel)


mapOptionalWithFeedback :
    Optional model submodel
    -> (submodel -> Response ( submodel, feedback ) submsg)
    -> feedback
    -> model
    -> Response ( model, feedback ) submsg
mapOptionalWithFeedback optional updater defaultFeedback model =
    case optional.getOption model of
        Nothing ->
            ( ( model, defaultFeedback ), Cmd.none )

        Just submodel ->
            let
                ( ( newSubmodel, feedback ), cmd ) =
                    updater submodel
            in
            ( ( optional.set newSubmodel model, feedback )
            , cmd
            )


addCmd : Cmd msg -> Response model msg -> Response model msg
addCmd cmd1 ( model, cmd2 ) =
    ( model, Cmd.batch [ cmd1, cmd2 ] )


withFeedback : feedback -> Response model msg -> Response ( model, feedback ) msg
withFeedback feedback ( model, msg ) =
    ( ( model, feedback ), msg )
