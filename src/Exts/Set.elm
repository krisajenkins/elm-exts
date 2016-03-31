module Exts.Set (..) where

{-| Extensions to the core `Set` library.

@docs select, uniqueItems

-}

import List exposing (filter)
import Set as Set exposing (Set, member)


{-| Pull any items from a list where (f x) is in the given set.
-}
select : (a -> comparable) -> Set comparable -> List a -> List a
select f keys =
  filter (\x -> member (f x) keys)


{-| Dive into a `List` to get a set of values.

  For example, pulling a `Set` of countries from a `List` of users.
-}
uniqueItems : (a -> Maybe comparable) -> List a -> Set comparable
uniqueItems accessor data =
  Set.fromList (List.filterMap accessor data)
