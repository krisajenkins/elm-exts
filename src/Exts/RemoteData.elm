module Exts.RemoteData (RemoteData(..), fromResult, withDefault, asEffect, mappend, map, isSuccess, mapFailure, mapBoth) where

{-| A datatype representing fetched data.

@docs RemoteData, map, mapFailure, mapBoth, withDefault, fromResult, asEffect, mappend, isSuccess
-}

import Task exposing (Task)
import Effects exposing (Effects)
import Exts.Task


{-| Frequently when you're fetching data from an API, you want to represent four different states:
  * `NotAsked` - We haven't asked for the data yet.
  * `Loading` - We've asked, but haven't got an answer yet.
  * `Failure` - We asked, but something went wrong. Here's the error.
  * `Success` - Everything worked, and here's the data.
-}
type RemoteData e a
  = NotAsked
  | Loading
  | Failure e
  | Success a


{-| Map a function into the `Success` value.
-}
map : (a -> b) -> RemoteData e a -> RemoteData e b
map f data =
  case data of
    Success x ->
      Success (f x)

    Failure e ->
      Failure e

    Loading ->
      Loading

    NotAsked ->
      NotAsked


{-| Map a function into the `Failure` value.
-}
mapFailure : (e -> f) -> RemoteData e a -> RemoteData f a
mapFailure f data =
  case data of
    Success x ->
      Success x

    Failure e ->
      Failure (f e)

    Loading ->
      Loading

    NotAsked ->
      NotAsked


{-| Map function into both the `Success` and `Failure` value.
-}
mapBoth : (a -> b) -> (e -> f) -> RemoteData e a -> RemoteData f b
mapBoth successFn errorFn data =
  case data of
    Success x ->
      Success (successFn x)

    Failure e ->
      Failure (errorFn e)

    Loading ->
      Loading

    NotAsked ->
      NotAsked


{-| Return the `Success` value, or the default.
-}
withDefault : a -> RemoteData e a -> a
withDefault default data =
  case data of
    Success x ->
      x

    _ ->
      default


{-| Convert a web `Task`, probably produced from elm-http, to a RemoteData Effect.
-}
asEffect : Task e a -> Effects (RemoteData e a)
asEffect =
  Exts.Task.asEffect
    >> Effects.map fromResult


{-| Convert a `Result Error`, probably produced from elm-http, to a RemoteData value.
-}
fromResult : Result e a -> RemoteData e a
fromResult result =
  case result of
    Err e ->
      Failure e

    Ok x ->
      Success x


{-| Monoidal append - join two `RemoteData` values together as though
they were one. If both values are Failure, the left one wins.
-}
mappend : RemoteData e a -> RemoteData e b -> RemoteData e ( a, b )
mappend a b =
  case ( a, b ) of
    ( Success x, Success y ) ->
      Success ( x, y )

    ( Failure x, _ ) ->
      Failure x

    ( _, Failure y ) ->
      Failure y

    ( NotAsked, _ ) ->
      NotAsked

    ( _, NotAsked ) ->
      NotAsked

    ( Loading, _ ) ->
      Loading

    ( _, Loading ) ->
      Loading


{-| State-checking predicate. Returns true if we've successfully loaded some data.
-}
isSuccess : RemoteData e a -> Bool
isSuccess data =
  case data of
    Success x ->
      True

    _ ->
      False
