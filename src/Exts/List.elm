module Exts.List (chunk, mergeBy, singleton, maybeSingleton, firstMatch, rest) where

{-| Extensions to the core `List` library.

@docs chunk, mergeBy, singleton, maybeSingleton, firstMatch, rest
-}

import Array exposing (Array)
import Trampoline exposing (..)
import List exposing (take, drop, length)
import Dict


{-| Split a list into chunks of length `n`.

  Be aware that the last sub-list may be smaller than `n`-items long.

  For example `chunk 3 [1..10] => [[1,2,3], [4,5,6], [7,8,9], [10]]`
-}
chunk : Int -> List a -> List (List a)
chunk n xs =
  if n < 1 then
    singleton xs
  else
    trampoline (chunk' n xs Array.empty)


chunk' : Int -> List a -> Array (List a) -> Trampoline (List (List a))
chunk' n xs accum =
  if List.isEmpty xs then
    Done (Array.toList accum)
  else
    Continue
      (\() ->
        chunk'
          n
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
