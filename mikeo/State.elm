port module State exposing (init, update, subscriptions)

import Json.Encode as E
import Monocle.Lens
import Rest exposing (..)
import Types exposing (..)
import RemoteData exposing (..)
import String exposing (toLower)


(=>) =
    Monocle.Lens.compose


init : Config -> ( Model, Cmd Msg )
init flags =
    ( { reportConfig = initialReportConfig flags
      , screenConfig = initialScreenConfig flags
      , inputRecipient = ""
      , constructConfig = initialConstructConfig flags
      , saveResponse = NotAsked
      , validationConfig =
            { constructs =
                ConstructValidation ( 1, "Not implemented" )
                -- User will not see this until implementation is complete
            , recipients =
                RecipientValidation ( 1, "Not implemented" )
                -- User will not see this until implementation is complete
            , errors = []
            }
      , debugMode = False
      }
    , Cmd.none
    )


initialReportConfig flags =
    let
        reportType =
            setReportTypeFromConfig flags.reportType

        constructs =
            case reportType of
                DailyQueue ->
                    flags.availableQueues

                DailyAgent ->
                    flags.availableAgents

                _ ->
                    []
    in
        ReportConfig flags.reportId
            (setReportTypeFromConfig flags.reportType)
            constructs
            flags.recipients


initialConstructConfig flags =
    ConstructConfig flags.availableQueues flags.availableAgents


initialScreenConfig flags =
    ScreenConfig "Choose Type"
        (if flags.reportId > 0 then
            ChooseConstructs
         else
            ChooseType
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigation step ->
            ( setNavigationStep step model
            , Cmd.none
            )

        SaveRecord ->
            let
                ( modelWithErrors, hasErrors ) =
                    validateForm model

                updatedModel =
                    if False == hasErrors then
                        ( { model | saveResponse = Loading }
                        , Cmd.map SaveRecordResponse (Rest.saveReportConfig model.reportConfig)
                        )
                    else
                        (let
                            modelWithErrorRedirect =
                                setNavigationStep ErrorList modelWithErrors
                         in
                            ( modelWithErrorRedirect, Cmd.none )
                        )
            in
                updatedModel

        SaveRecordResponse response ->
            ( { model | saveResponse = response }
            , redirect "/portal/clarity/scheduledReport"
            )

        SelectType code ->
            let
                updatedReportTypeModel =
                    (setReportType code model)

                updatedModel =
                    (setConstructModel updatedReportTypeModel code)
            in
                ( updatedModel, Cmd.none )

        ToggleAllConstructs selected ->
            let
                currentConstructs =
                    .get (reportConfigLens => constructsLens) model
            in
                ( .set (reportConfigLens => constructsLens) (toggleAllConstructs currentConstructs selected) model
                , Cmd.none
                )

        ToggleConstruct extension ->
            let
                currentConstructs =
                    .get (reportConfigLens => constructsLens) model
            in
                ( .set (reportConfigLens => constructsLens) (toggleConstructsSelected currentConstructs extension) model
                , Cmd.none
                )

        UpdateInputRecipient email ->
            ( { model | inputRecipient = email }
            , Cmd.none
            )

        AddRecipient email ->
            let
                currentRecipients =
                    .get (reportConfigLens => recipientsLens) model

                recipientExists =
                    List.any (checkRecipientExists email) currentRecipients

                updatedRecipients =
                    if not recipientExists then
                        .set (reportConfigLens => recipientsLens) (addRecipient currentRecipients email) model
                    else
                        model

                updatedModel =
                    if not recipientExists then
                        { updatedRecipients | inputRecipient = "" }
                    else
                        model
            in
                ( updatedModel, Cmd.none )

        ToggleRecipient email ->
            let
                currentRecipients =
                    .get (reportConfigLens => recipientsLens) model
            in
                ( .set (reportConfigLens => recipientsLens) (toggleRecipient currentRecipients email) model
                , Cmd.none
                )

        DeleteRecipient email ->
            let
                currentRecipients =
                    .get (reportConfigLens => recipientsLens) model
            in
                ( .set (reportConfigLens => recipientsLens) (deleteRecipient currentRecipients email) model
                , Cmd.none
                )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


setReportType code model =
    .set (reportConfigLens => reportTypeLens) code model


setReportTypeFromConfig reportType =
    case reportType of
        "daily queue" ->
            DailyQueue

        "daily agent" ->
            DailyAgent

        _ ->
            NoType


toggleConstructsSelected constructs extension =
    List.map
        (\construct ->
            if construct.extension == extension then
                { construct | selected = not construct.selected }
            else
                construct
        )
        constructs


toggleAllConstructs constructs selected =
    List.map (\construct -> { construct | selected = selected }) constructs


addRecipient recipients email =
    List.append recipients [ (Recipient email True) ]


toggleRecipient recipients email =
    List.map
        (\recipient ->
            if recipient.email == email then
                { recipient | active = not recipient.active }
            else
                recipient
        )
        recipients


deleteRecipient recipients email =
    List.filter (\recipient -> recipient.email /= email)
        recipients


getConstructSelected model =
    .get (reportConfigLens => constructsLens => selectedLens) model


getReportConfig model =
    .get (reportConfigLens) model


getReportType model =
    .get (reportConfigLens => reportTypeLens) model


setConstructModel model code =
    let
        constructs =
            case code of
                DailyQueue ->
                    .get (constructConfigLens => availableQueuesLens) model

                DailyAgent ->
                    .get (constructConfigLens => availableAgentsLens) model

                _ ->
                    .get (reportConfigLens => constructsLens) model
    in
        .set (reportConfigLens => constructsLens) constructs model


setNavigationStep step model =
    .set (screenConfigLens => screenNavigationLens) step model


checkRecipientExists email recipient =
    recipient.email == email


getTypeLabel model =
    case (.get (reportConfigLens => reportTypeLens) model) of
        DailyQueue ->
            "Queue"

        _ ->
            "Agent"



-- Validation


validateForm model =
    let
        typeLabel =
            getTypeLabel model

        errors =
            (validationConfigLens => validationErrorsLens)

        constructsError =
            if validateConstructs model then
                []
            else
                [ ( typeLabel ++ "s", "Must select at least 1 " ++ (toLower typeLabel), (Navigation ChooseConstructs) ) ]

        recipientsError =
            if validateRecipients model then
                []
            else
                [ ( "Recipients", "Must have at least 1 active recipient", (Navigation ChooseRecipients) ) ]

        errorList =
            List.concat [ constructsError, recipientsError ]

        x =
            Debug.log "errorList" errorList

        updatedModel =
            .set (validationConfigLens => validationErrorsLens) errorList model

        hasErrors =
            if List.length errorList > 0 then
                True
            else
                False
    in
        ( updatedModel, hasErrors )


validateConstructs : Model -> Bool
validateConstructs model =
    let
        constructs =
            reportConfigLens => constructsLens

        constructCount =
            (constructs.get model)
                |> List.filter .selected
                |> List.length

        validationCheck =
            if constructCount >= 1 then
                True
            else
                False
    in
        validationCheck


validateRecipients : Model -> Bool
validateRecipients model =
    let
        recipients =
            reportConfigLens => recipientsLens

        recipientCount =
            (recipients.get model)
                |> List.filter .active
                |> List.length

        validationCheck =
            if recipientCount >= 1 then
                True
            else
                False
    in
        validationCheck



-- Ports


port redirect : String -> Cmd msg
