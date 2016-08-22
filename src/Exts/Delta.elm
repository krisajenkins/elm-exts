module Exts.Delta exposing (Delta, empty, generation)

{-| A system for tracking players that enter and leave a stage, a-la D3.

Implementation detail: This code is hampered by the lack of Elm's type classes. Note the following:
1. Performance may degrade badly as the number of elements increases.
2. It is up to you to ensure (a) implments Eq correctly.

@docs Delta
@docs empty
@docs generation
-}

import List exposing (append, partition, (::))


filter : (a -> Bool) -> List a -> List a
filter p xs =
    case xs of
        [] ->
            []

        x :: xs ->
            if p x then
                x :: (filter p xs)
            else
                filter p xs


remove : (a -> Bool) -> List a -> List a
remove p =
    filter (not << p)


diff : List a -> List a -> List a
diff xs ys =
    remove (\x -> listContains x ys) xs


union : List a -> List a -> List a
union xs ys =
    append xs (diff ys xs)


intersect : List a -> List a -> List a
intersect xs ys =
    List.filter (\x -> listContains x ys) xs


listContains : a -> List a -> Bool
listContains x =
    List.any ((==) x)


{-| A data-structure that maintains the difference list of entering, continuing and leaving players.
-}
type alias Delta a =
    { entering : List a
    , continuing : List a
    , leaving : List a
    }


{-| A default starting state for Deltas.
-}
empty : Delta a
empty =
    { entering = []
    , continuing = []
    , leaving = []
    }


{-| Update the delta by inspecting a list of players.
-}
generation : List a -> Delta a -> Delta a
generation xs ds =
    let
        actives =
            union ds.entering ds.continuing

        newEntries =
            diff xs actives

        newLeavers =
            diff actives xs

        newContinuers =
            intersect xs actives
    in
        { empty
            | entering = newEntries
            , continuing = newContinuers
            , leaving = newLeavers
        }
