module Exts.Html.Bootstrap where

{-| Base classes for Twitter Bootstrap 3 users.

@docs container, containerFluid, row, empty, twoColumns
-}

import Html exposing (..)
import Html.Attributes exposing (..)

{-| Bootstrap grid container. -}
container : List Html -> Html
container = div [class "container"]

{-| Bootstrap grid fluid container. -}
containerFluid : List Html -> Html
containerFluid = div [class "container-fluid"]

{-| Bootstrap grid row. -}
row : List Html -> Html
row = div [class "row"]

{-| The minimum markup - an empty span. -}
empty : Html
empty = span [] []

{-| Two evenly-sized columns. Must be used within a row. -}
twoColumns : List Html -> List Html -> Html
twoColumns left right =
  row [div [class "col-xs-6"] left
      ,div [class "col-xs-6"] right]
