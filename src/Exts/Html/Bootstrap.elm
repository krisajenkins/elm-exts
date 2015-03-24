module Exts.Html.Bootstrap where

{-| Bootstrap support. |-}

import Html (..)
import Html.Attributes (..)
import List

container : List Html -> Html
container = div [class "container"]

containerFluid : List Html -> Html
containerFluid = div [class "container-fluid"]

row : List Html -> Html
row = div [class "row"]
