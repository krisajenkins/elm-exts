module Exts.List
    exposing
        ( chunk
        , mergeBy
        , singleton
        , maybeSingleton
        , firstMatch
        , rest
        , unique
        , exactlyOne
        )

{-| Extensions to the core `List` library.

@docs chunk
@docs mergeBy
@docs singleton
@docs maybeSingleton
@docs firstMatch
@docs rest
@docs unique
@docs exactlyOne
-}

import Array exposing (Array)
import Dict
import List exposing (take, drop, length)
import Set
import Trampoline exposing (..)


{-| Split a list into chunks of length `n`.

  Be aware that the last sub-list may be smaller than `n`-items long.

  For example `chunk 3 [1..10] => [[1,2,3], [4,5,6], [7,8,9], [10]]`
-}
chunk : Int -> List a -> List (List a)
chunk n xs =
    if n < 1 then
        singleton xs
    else
        evaluate (chunk' n xs Array.empty)


chunk' : Int -> List a -> Array (List a) -> Trampoline (List (List a))
chunk' n xs accum =
    if List.isEmpty xs then
        done (Array.toList accum)
    else
        jump
            (\() ->
                chunk' n
                    (drop n xs)
                    (Array.push (take n xs) accum)
            )


{-| Merge two lists. The first argument is a function which returns
the unique ID of each element. Where an element appears more than
once, the last won wins.
-}
mergeBy : (a -> comparable) -> List a -> List a -> List a
mergeBy f xs ys =
    let
        reducer v acc =
            Dict.insert (f v) v acc
    in
        Dict.values (List.foldl reducer Dict.empty (xs ++ ys))


{-| Wrap a single item into a `List`.
-}
singleton : a -> List a
singleton x =
    [ x ]


{-| Wrap a maybe item into a `List`. If the item is `Nothing`, the `List` is empty.
-}
maybeSingleton : Maybe a -> List a
maybeSingleton =
    Maybe.map singleton
        >> Maybe.withDefault []


{-| Find the first element in the `List` that matches the given predicate.
-}
firstMatch : (a -> Bool) -> List a -> Maybe a
firstMatch predicate items =
    case items of
        [] ->
            Nothing

        x :: xs ->
            if predicate x then
                Just x
            else
                (firstMatch predicate xs)


{-| Like List.tail, but if the list is empty it returns an empty list rather than `Nothing`.
-}
rest : List a -> List a
rest =
    List.tail
        >> Maybe.withDefault []


{-| Return a new list with duplicates removed. Order is preserved.
-}
unique : List comparable -> List comparable
unique =
    let
        f x ( seen, result ) =
            if Set.member x seen then
                ( seen, result )
            else
                ( Set.insert x seen, x :: result )
    in
        List.foldl f ( Set.empty, [] )
            >> snd
            >> List.reverse


{-| Extract the first item from the `List`, demanding that there be exactly one element.

For example, `Json.Decode.customDecoder string exactlyOne` creates a
decoder that expects a list of strings, where there is only one
element in the `List`.

If you think that's weird, you haven't seen enough real-world JSON. ;-)
-}
exactlyOne : List a -> Result String a
exactlyOne xs =
    case xs of
        [] ->
            Err "Expected a list with one item. Got an empty list."

        [ x ] ->
            Ok x

        x :: xs ->
            Err <| "Expected a list with one item. Got " ++ toString (List.length xs) ++ " items."
