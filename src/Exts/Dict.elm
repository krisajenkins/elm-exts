module Exts.Dict (..) where

{-| Extensions to the core `Dict` library.

@docs indexBy, groupBy, frequency, getWithDefault, foldToList

-}

import Dict exposing (Dict, insert)


{-| Turn a list of items into an indexed dictionary.

  Supply an indexing function (eg. `.id`) and a list of
  items. `indexBy` returns a dictionary with each item stored under
  its index.

  This code assumes each index is unique. If that is not the case, you
  should use `groupBy` instead.
-}
indexBy : (v -> comparable) -> List v -> Dict comparable v
indexBy f =
  List.foldl (\x -> insert (f x) x) Dict.empty


{-| Group a list of items by a key.

  Supply an indexing function (eg. `.id`) and a list of
  items. `groupBy` returns a dictionary of group-key/list-of-items.

  If the indexing function returns a unique key for every item, consider `indexBy` instead.
-}



-- TODO This function would be more efficient if it used Dict.update, instead of Dict.insert.


groupBy : (v -> comparable) -> List v -> Dict comparable (List v)
groupBy f =
  let
    reducer g x d =
      let
        key =
          g x

        newValue =
          x :: Maybe.withDefault [] (Dict.get key d)
      in
        insert key newValue d
  in
    List.foldl (reducer f) Dict.empty


{-| Create a frequency-map from the given list.
-}
frequency : List comparable -> Dict comparable Int
frequency =
  let
    updater m =
      case m of
        Nothing ->
          Just 1

        Just n ->
          Just (n + 1)

    reducer x =
      Dict.update x updater
  in
    List.foldl reducer Dict.empty


{-| Attempt to find a key, if it's not there, return a default value.
-}
getWithDefault : a -> comparable -> Dict comparable a -> a
getWithDefault def key =
  Maybe.withDefault def << Dict.get key


{-| Run a function over the dictionary entries, resulting in a list of the final results.
-}
foldToList : (comparable -> v -> b) -> Dict.Dict comparable v -> List b
foldToList f dict =
  Dict.foldr
    (\k v -> (::) (f k v))
    []
    dict
