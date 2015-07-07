module Exts.Dict where

{-| Extensions to the core Dict library.

@docs indexBy, groupBy

-}

import Dict exposing (Dict,insert)

{-| Turn a list of items into an indexed dictionary.

  Supply an indexing function (eg. `.id`) and a list of
  items. `indexBy` returns a dictionary with each item stored under
  its index.

  This code assumes each index is unique. If that is not the case, you
  should use `groupBy` instead.
-}
indexBy : (v -> comparable) -> List v -> Dict comparable v
indexBy f = List.foldl (\x -> insert (f x) x) Dict.empty

{-| Group a list of items by a key.

  Supply an indexing function (eg. `.id`) and a list of
  items. `groupBy` returns a dictionary of group-key/list-of-items.

  If the indexing function returns a unique key for every item, consider `indexBy` instead.
-}
groupBy : (v -> comparable) -> List v -> Dict comparable (List v)
groupBy f =
  let reducer g x d = let key = g x
                          newValue = x :: Maybe.withDefault [] (Dict.get key d)
                      in insert key newValue d
  in List.foldl (reducer f) Dict.empty