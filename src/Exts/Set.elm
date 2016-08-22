module Exts.Set exposing (..)

{-| Extensions to the core `Set` library.

@docs select
@docs uniqueItems
@docs toggle

-}

import List exposing (filter)
import Set exposing (Set, member)


{-| Pull any items from a list where (f x) is in the given set.
-}
select : (a -> comparable) -> Set comparable -> List a -> List a
select f keys =
    filter (\x -> member (f x) keys)


{-| Dive into a `List` to get a set of values.

  For example, pulling a `Set` of countries from a `List` of users.
-}
uniqueItems : (a -> Maybe comparable) -> List a -> Set comparable
uniqueItems accessor =
    List.filterMap accessor >> Set.fromList


{-| If x is a member of the set, remove it. Otherwise, add it.
-}
toggle : comparable -> Set comparable -> Set comparable
toggle key set =
    if member key set then
        Set.remove key set
    else
        Set.insert key set
