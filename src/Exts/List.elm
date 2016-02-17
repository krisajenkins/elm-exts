module Exts.List (chunk, mergeBy, singleton) where

{-| Extensions to the core List library.

@docs chunk, mergeBy, singleton
-}

import Array exposing (Array)
import Trampoline exposing (..)
import List exposing (take, drop, length)
import Dict


{-| Split a list into chunks of length n.

  Be aware that the last sub-list may be smaller than n-items long.

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


{-| Wrap a single item into a list.
-}
singleton : a -> List a
singleton x =
  [ x ]
