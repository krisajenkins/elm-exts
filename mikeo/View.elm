module View exposing (root)

import String
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Types exposing (..)
import Common.Form exposing (..)
import Exts.Html.Bootstrap as Bootstrap
import Exts.Html.Bootstrap.Glyphicons exposing (glyphicon, Glyphicon(..))
import Material.Icons.Social exposing (group)
import Material.Icons.Communication exposing (call_split)
import Switch
import Color exposing (..)
import Monocle.Lens
import RemoteData exposing (..)


(=>) =
    Monocle.Lens.compose


root : Model -> Html Msg
root model =
    let
        viewStep =
            case getNavigationStep model of
                ChooseType ->
                    viewChooseType model

                ChooseConstructs ->
                    viewChooseConstructs model

                ChooseRecipients ->
                    viewChooseRecipients model

                ErrorList ->
                    viewErrorList model

                _ ->
                    viewChooseType model

        view =
            if model.debugMode then
                div []
                    [ div [] [ code [] [ text <| toString model.saveResponse ] ]
                    , viewStep
                    ]
            else
                viewStep
    in
        view


viewChooseType model =
    let
        btnDisabled =
            .get (reportConfigLens => reportTypeLens) model == NoType
    in
        screenContainer "Choose Type"
            (reportTypeIcons model)
            [ navigationButton "color-primary" btnDisabled (Navigation ChooseConstructs) "Next" ]


viewChooseConstructs model =
    let
        typeLabel =
            case (.get (reportConfigLens => reportTypeLens) model) of
                DailyQueue ->
                    "Queue"

                _ ->
                    "Agent"

        constructs =
            .get (reportConfigLens => constructsLens) model

        emptyAvailableMessage =
            "No " ++ typeLabel ++ "s available"

        emptySelectedMessage =
            "No " ++ typeLabel ++ "s selected, click on an " ++ typeLabel ++ " in the \"Available\" list to add it"

        ( selectedConstructs, availableConstructs ) =
            (List.partition .selected constructs)

        navigationButtonBack =
            if (getReportId model) == 0 then
                [ navigationButton "" False (Navigation ChooseType) "Back" ]
            else
                []

        navigationButtonNext =
            [ navigationButton "color-primary" False (Navigation ChooseRecipients) "Next" ]

        navigationButtons =
            List.concat [ navigationButtonBack, navigationButtonNext ]
    in
        screenContainer ("Choose " ++ typeLabel ++ "s")
            [ Bootstrap.containerFluid
                [ Bootstrap.row
                    [ div [ class "col-sm-12" ]
                        [ table []
                            [ tr []
                                [ td [] [ h5 [] [ text "Available (click to add)" ], (constructList availableConstructs emptyAvailableMessage) ]
                                , td [ class "container-select-buttons" ] [ (constructSelectButton (ToggleAllConstructs True) ChevronRight), (constructSelectButton (ToggleAllConstructs False) ChevronLeft) ]
                                , td [] [ h5 [] [ text "Selected (click to remove)" ], (constructList selectedConstructs emptySelectedMessage) ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
            navigationButtons


isIn value items =
    True


viewChooseRecipients model =
    let
        recipients =
            .get (reportConfigLens => recipientsLens) model

        saving =
            if List.member model.saveResponse [ Loading, Success Acknowledgement ] then
                True
            else
                False

        finishButtonMessage =
            if saving then
                "Saving..."
            else
                "Finish"

        navigationBackButton =
            [ navigationButton "" False (Navigation ChooseConstructs) "Back" ]

        navigationFinishButton =
            [ navigationButton
                ("color-primary"
                    ++ (if saving then
                            " disabled"
                        else
                            ""
                       )
                )
                False
                SaveRecord
                finishButtonMessage
            ]

        navigationButtons =
            List.concat [ navigationBackButton, navigationFinishButton ]
    in
        screenContainer "Choose Recipients"
            [ div [] [ (recipientInput model.inputRecipient), (recipientTable recipients) ] ]
            navigationButtons


viewErrorList model =
    let
        errors =
            .get (validationConfigLens => validationErrorsLens) model

        recipients =
            .get (reportConfigLens => recipientsLens) model
    in
        screenContainer "This form contains errors that must be resolved before saving"
            [ div [] (List.map (alertMessage) errors) ]
            [ navigationButton "" False (Navigation ChooseRecipients) "Back" ]


chooseTypeButtons =
    button [ onClick (Navigation ChooseConstructs) ] [ text "Next" ]


screenContainer : String -> List (Html Msg) -> List (Html Msg) -> Html Msg
screenContainer title body buttons =
    Bootstrap.containerFluid
        [ Bootstrap.row
            [ (screenHeader "Report Editor")
            , (screenBody title body)
            , (screenFooter buttons)
            ]
        ]


screenHeader title =
    div [ class "modal-header" ]
        [ button
            [ type' "button"
            , class "close cancel"
            , attribute "data-dismiss" "modal"
            , attribute "aria-hidden" "true"
            , attribute "onClick" "parent.hideModal('#scheduled-report-editor');"
            ]
            [ text "x" ]
        , h4 [] [ text title ]
        ]


screenBody title body =
    div [ class "modal-body" ]
        [ h5 [] [ text title ]
        , hr [] []
        , Bootstrap.container
            [ Bootstrap.row
                [ div [ class "wizard-screen-body" ] body
                ]
            ]
        ]


screenFooter buttons =
    div [ class "modal-footer", attribute "style" "display: block;" ] buttons



-- Fields


constructList constructs emptyMessage =
    let
        content =
            if List.isEmpty constructs then
                [ div [ class "empty-text" ] [ text emptyMessage ] ]
            else
                (List.map constructButton constructs)
    in
        div [ class "construct-container" ] content


recipientInput email =
    Bootstrap.container
        [ Bootstrap.row
            [ formInline
                [ div
                    [ classList [ ( "form-group-inline form-group-sm", True ) ]
                    ]
                    [ fieldLabel "Recipient Email Address"
                    , fieldBody
                        [ formGroup
                            [ input
                                [ type' "text"
                                , class "form-control-inline recipient-email"
                                , onInput UpdateInputRecipient
                                , placeholder "Enter a valid email address"
                                , autofocus True
                                , value email
                                ]
                                []
                            , button [ onClick (AddRecipient email), class "btn color-primary" ] [ text "Add" ]
                            ]
                        , (messageErrorRecipientExists False)
                          -- Update with logic
                        ]
                    ]
                ]
            ]
        ]



-- Buttons


reportTypeIcons model =
    [ div [ class "screen-choose-type" ]
        [ reportTypeIcon model "Daily Queue" call_split (SelectType DailyQueue)
        , reportTypeIcon model "Daily Agent" group (SelectType DailyAgent)
        ]
    ]


reportTypeIcon model typeLabel code msg =
    let
        reportType =
            .get (reportConfigLens => reportTypeLens) model

        iconClass =
            if msg == SelectType reportType then
                [ class (reportTypeIconClass ++ " selected") ]
            else
                [ class reportTypeIconClass ]

        iconClickHandler =
            if msg == SelectType reportType then
                []
            else
                [ onClick msg ]

        iconAttributes =
            List.append iconClass iconClickHandler
    in
        span []
            [ div iconAttributes [ (code brandPrimaryColor 100), div [] [ text (typeLabel ++ " Report") ] ]
            ]


constructButton construct =
    let
        secondaryClass =
            if construct.selected then
                " color-primary"
            else
                ""

        icon =
            if construct.selected then
                (glyphicon Remove)
            else
                span [] []
    in
        button [ onClick (ToggleConstruct construct.extension), class (String.concat [ "btn", secondaryClass ]) ] [ text (String.concat [ construct.extension, " (", construct.label, ") " ]) ]


constructSelectButton msg icon =
    button [ class "btn btn-sm btn-round", onClick msg ] [ glyphicon icon ]


cancelButton =
    button [ type' "button", class "btn", attribute "data-dismiss" "modal", attribute "aria-hidden" "true", onClick "parent.hideModal('#scheduled-report-editor');" ] [ text "Cancel" ]


navigationButton secondaryClass isDisabled action actionLabel =
    let
        disabledStatus =
            disabled isDisabled
    in
        button [ class ("btn " ++ secondaryClass), disabledStatus, onClick action ] [ text actionLabel ]



-- Tables


recipientTable recipients =
    Bootstrap.container
        [ Bootstrap.row
            [ table [ class "table table-condensed recipients" ]
                [ thead []
                    [ tr []
                        [ th [] [ text "Email Address" ]
                        , th [ class "cell-with-icon" ] [ text "Enabled" ]
                        , th [ class "cell-with-icon" ] [ text "" ]
                        ]
                    ]
                , tbody []
                    (List.map recipientRow recipients)
                ]
            ]
        ]


recipientRow recipient =
    tr []
        [ td []
            [ text recipient.email ]
        , td []
            [ fieldBody [ Switch.root recipient.active (ToggleRecipient recipient.email) ]
            ]
        , td [ style [ ( "color", "red" ) ] ]
            [ button [ class "btn btn-sm btn-round btn-error", onClick (DeleteRecipient recipient.email) ] [ glyphicon Remove ] ]
        ]



-- Messages


messageErrorRecipientExists recipientExists =
    if recipientExists then
        div [ class "alert alert-danger", attribute "role" "alert" ]
            [ text "Recipient already exists and will not be added" ]
    else
        div [] []


alertMessage details =
    let
        ( fieldName, message, resolveAction ) =
            details
    in
        div [ class "alert alert-danger", attribute "role" "alert" ]
            [ strong [] [ text fieldName ]
            , text (" " ++ message)
            , button [ class "btn", onClick resolveAction ] [ text "Resolve" ]
            ]



-- Colors


brandPrimaryColor =
    rgb 251 169 59



-- CSS Classes


reportTypeIconClass =
    "report-type-icon"



-- Getters


getReportId model =
    .get (reportConfigLens => reportIdLens) model


getNavigationStep =
    .get (screenConfigLens => screenNavigationLens)
