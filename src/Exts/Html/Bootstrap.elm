module Exts.Html.Bootstrap where

{-| Bootstrap support. |-}

import Html exposing (..)
import Html.Attributes exposing (..)

container : List Html -> Html
container = div [class "container"]

containerFluid : List Html -> Html
containerFluid = div [class "container-fluid"]

row : List Html -> Html
row = div [class "row"]

empty : Html
empty = span [] []

twoColumns : List Html -> List Html -> Html
twoColumns left right =
  row [div [class "col-xs-6"] left
      ,div [class "col-xs-6"] right]
