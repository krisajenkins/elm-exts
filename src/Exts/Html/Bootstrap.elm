module Exts.Html.Bootstrap where

{-| Base classes for Twitter Bootstrap 3 users.

@docs container, containerFluid, row, empty, twoColumns, Ratio, video
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

{-| Aspect ratios for responsive video embedding. -}
type Ratio
  = SixteenByNine
  | FourByThree

{-| Embed a responsive video. -}
video : Ratio -> String -> Html
video ratio url =
  let ratioClass = case ratio of
                     SixteenByNine -> "embed-responsive-16by9"
                     FourByThree   -> "embed-responsive-4by3"
  in div []
         [h1 [] [text "About"]
         ,div [class "embed-responsive"]
              [iframe [class "embed-responsive-item"
                      ,src url]
                      []]]
