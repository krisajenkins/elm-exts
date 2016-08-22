module Exts.Html.Table exposing (CellDef, TableDef, simpleTable, simpleTableRow, titleGroup, valueGroup)

{-| Helpers for simple data tables. Define how a list of items can be
rendered as a table. The definition is a `List` of `(column-title,
column-value-accessor)` pairs.

  I find this approach works well for simple tables, but breaks down
  as soon as you need much customisation. Use it to get you started
  quickly, but be ready to rewrite when this 80% case no longer suits.

@docs CellDef
@docs TableDef
@docs simpleTable
@docs simpleTableRow
@docs titleGroup
@docs valueGroup
-}

import Html exposing (..)
import Html.Attributes exposing (..)


{-| A table definition looks something like:

    [(text "Name", .name >> text)
    ,(text "Name", .age >> toString >> text)]

-}
type alias CellDef a msg =
    ( Html msg, a -> Html msg )


{-| -}
type alias TableDef a msg =
    List (CellDef a msg)


{-| Given a table definition, render a list of elements as HTML.
-}
simpleTable : TableDef a msg -> List a -> Html msg
simpleTable tableDef items =
    table [ class "table table-bordered table-hover" ]
        [ thead []
            [ tr []
                (List.map (\( title, _ ) -> (th [] [ title ]))
                    tableDef
                )
            ]
        , tbody [] (List.map (simpleTableRow tableDef) items)
        ]


{-| Given a table definition, render an element to a <tr> tag. This is
lower-level. Usually you will want `simpleTable` instead.
-}
simpleTableRow : TableDef a msg -> a -> Html msg
simpleTableRow tableDef item =
    tr []
        (List.map (\( _, f ) -> (td [] [ f item ]))
            tableDef
        )


{-| titleGroup and valueGroup are used to create columns that stack multiple pairs. For example:

    [(titleGroup ["Latitude", "Longitude"]
     ,valueGroup [.location >> .lat >> toString >> text
                 ,.location >> .lng >> toString >> text])

-}
titleGroup : List String -> Html msg
titleGroup strings =
    div [] (List.map (\s -> div [] [ text s ]) strings)


{-| -}
valueGroup : List (a -> Html msg) -> a -> Html msg
valueGroup fs x =
    div [] (List.map (\f -> div [] [ f x ]) fs)
