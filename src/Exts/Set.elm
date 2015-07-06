module Exts.Set where

{-| Extensions to the core Maybe library. |-}

import List exposing (filter)
import Set as Set exposing (Set, member)

select : (a -> comparable) -> Set comparable -> List a -> List a
select f keys = filter (\x -> member (f x) keys)

uniqueItems : (a -> Maybe comparable) -> List a -> Set comparable
uniqueItems accessor data = Set.fromList (List.filterMap accessor data)
