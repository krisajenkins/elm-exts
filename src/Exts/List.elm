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
        , maximumBy
        , minimumBy
        , unfold
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
@docs maximumBy
@docs minimumBy
@docs unfold
-}

import Array exposing (Array)
import Dict
import Exts.Basics exposing (maxBy, minBy)
import List exposing (take, drop, length)
import Set
import Trampoline exposing (..)
import Tuple exposing (second)


{-| Split a list into chunks of length `n`.

  Be aware that the last sub-list may be smaller than `n`-items long.

  For example `chunk 3 [1..10] => [[1,2,3], [4,5,6], [7,8,9], [10]]`
-}
chunk : Int -> List a -> List (List a)
chunk n xs =
    if n < 1 then
        singleton xs
    else
        evaluate (chunkInternal n xs Array.empty)


chunkInternal : Int -> List a -> Array (List a) -> Trampoline (List (List a))
chunkInternal n xs accum =
    if List.isEmpty xs then
        done (Array.toList accum)
    else
        jump
            (\() ->
                chunkInternal n
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
firstMatch predicate =
    List.foldl
        (\item acc ->
            case acc of
                Just _ ->
                    acc

                Nothing ->
                    if predicate item then
                        Just item
                    else
                        Nothing
        )
        Nothing


{-| Like List.tail, but if the list is empty it returns an empty list rather than `Nothing`.
-}
rest : List a -> List a
rest =
    List.tail >> Maybe.withDefault []


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
            >> second
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


{-| Like `List.maximum`, but it works on non-comparable types by taking a custom function.
-}
maximumBy : (a -> comparable) -> List a -> Maybe a
maximumBy toComparable list =
    case list of
        x :: xs ->
            Just (List.foldl (maxBy toComparable) x xs)

        _ ->
            Nothing


{-| Like `List.minimum`, but it works on non-comparable types by taking a custom function.
-}
minimumBy : (a -> comparable) -> List a -> Maybe a
minimumBy toComparable list =
    case list of
        x :: xs ->
            Just (List.foldl (minBy toComparable) x xs)

        _ ->
            Nothing


{-| Generate a `List` from a function and a seed value.

I feel sorry for `unfold` - it doesn't get nearly as much love as
`map` and `fold`, despite being in the same family.
-}
unfold : (b -> Maybe ( b, a )) -> b -> List a
unfold f seed =
    unfoldInternal f ( seed, Array.empty )
        |> evaluate


unfoldInternal : (b -> Maybe ( b, a )) -> ( b, Array a ) -> Trampoline (List a)
unfoldInternal f ( seed, accumulator ) =
    case f seed of
        Nothing ->
            done (Array.toList accumulator)

        Just ( newSeed, next ) ->
            unfoldInternal f ( newSeed, Array.push next accumulator )
