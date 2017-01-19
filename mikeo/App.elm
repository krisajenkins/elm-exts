module App exposing (main)

import Html.App
import State
import Types exposing (Config)
import View



main : Program Config
main =
    Html.App.programWithFlags
        { init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.root
        }
