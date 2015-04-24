module Exts.Html.Table where

{-| Helpers for simple data tables.
    I find this approach brakes down for all but simple tables, so be
    ready to rewrite when this 80% case no longer suits.
|-}

import Html exposing (..)
import Html.Attributes exposing (..)

titleGroup : List String -> Html
titleGroup strings = div [] (List.map (\s -> div [] [text s]) strings)

valueGroup : List (a -> Html) -> a -> Html
valueGroup fs x = div [] (List.map (\f -> div [] [f x]) fs)


type alias CellDef a = (Html, (a -> Html))
type alias TableDef a = List (CellDef a)

simpleTable : TableDef a -> List a -> Html
simpleTable tableDef items =
  table [class "table table-bordered table-hover"]
        [thead [] [tr [] (List.map (\ (title,_) -> (th [] [title]))
                                   tableDef)]
        ,tbody [] (List.map (simpleTableRow tableDef) items)]

simpleTableRow : TableDef a -> a -> Html
simpleTableRow tableDef item =
  tr []
     (List.map (\ (_,f) -> (td [] [f item]))
               tableDef)
