module Exts.Set where

{-| Extensions to the core Maybe library. |-}

import List
import List (filter)
import Set
import Set (Set, member)

select : (a -> comparable) -> Set comparable -> List a -> List a
select f keys = filter (\x -> member (f x) keys)

uniqueItems : (a -> Maybe String) -> List a -> Set String
uniqueItems accessor data = Set.fromList (List.filterMap accessor data)
