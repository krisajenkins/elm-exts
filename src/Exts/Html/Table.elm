module Exts.Html.Table (CellDef, TableDef, simpleTable, simpleTableRow, titleGroup, valueGroup) where

{-| Helpers for simple data tables. Define how a list of items can be
rendered as a table. The definition is a `List` of `(column-title,
column-value-accessor)` pairs.

  I find this approach works well for simple tables, but breaks down
  as soon as you need much customisation. Use it to get you started
  quickly, but be ready to rewrite when this 80% case no longer suits.

@docs CellDef, TableDef, simpleTable, simpleTableRow, titleGroup, valueGroup
-}

import Html exposing (..)
import Html.Attributes exposing (..)


{-| A table definition looks something like:

    [(text "Name", .name >> text)
    ,(text "Name", .age >> toString >> text)]

-}
type alias CellDef a =
  ( Html, a -> Html )


{-| -}
type alias TableDef a =
  List (CellDef a)


{-| Given a table definition, render a list of elements as HTML.
-}
simpleTable : TableDef a -> List a -> Html
simpleTable tableDef items =
  table
    [ class "table table-bordered table-hover" ]
    [ thead
        []
        [ tr
            []
            (List.map
              (\( title, _ ) -> (th [] [ title ]))
              tableDef
            )
        ]
    , tbody [] (List.map (simpleTableRow tableDef) items)
    ]


{-| Given a table definition, render an element to a <tr> tag. This is
lower-level. Usually you will want `simpleTable` instead.
-}
simpleTableRow : TableDef a -> a -> Html
simpleTableRow tableDef item =
  tr
    []
    (List.map
      (\( _, f ) -> (td [] [ f item ]))
      tableDef
    )


{-| titleGroup and valueGroup are used to create columns that stack multiple pairs. For example:

    [(titleGroup ["Latitude", "Longitude"]
     ,valueGroup [.location >> .lat >> toString >> text
                 ,.location >> .lng >> toString >> text])

-}
titleGroup : List String -> Html
titleGroup strings =
  div [] (List.map (\s -> div [] [ text s ]) strings)


{-| -}
valueGroup : List (a -> Html) -> a -> Html
valueGroup fs x =
  div [] (List.map (\f -> div [] [ f x ]) fs)
