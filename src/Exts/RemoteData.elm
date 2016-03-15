module Exts.RemoteData (RemoteData(..), fromResult, withDefault, asEffect, mappend, map) where

{-| A datatype representing fetched data.

@docs RemoteData , fromResult, withDefault, asEffect, mappend, map
-}

import Http exposing (Error(..))
import Task exposing (Task)
import Effects exposing (Effects)


{-| Frequently when you're fetching data from an API, you want to represent 4 different states:
  * `NotAsked` - We haven't asked for the data yet.
  * `Loading` - We've asked, but haven't got an answer yet.
  * `Failure` - We asked, but something went wrong. Here's the `Error`.
  * `Success` - Everything worked, and here's the data.
-}
type RemoteData a
  = NotAsked
  | Loading
  | Failure Error
  | Success a


{-| Map a function into the `Success` value.
-}
map : (a -> b) -> RemoteData a -> RemoteData b
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


{-| Return the `Success` value, or the default.
-}
withDefault : a -> RemoteData a -> a
withDefault default data =
  case data of
    Success x ->
      x

    _ ->
      default


{-| Convert a web `Task`, probably produced from elm-http, to a RemoteData Effect.
-}
asEffect : Task Error a -> Effects (RemoteData a)
asEffect =
  Effects.map fromResult << Effects.task << Task.toResult


{-| Convert a `Result Error`, probably produced from elm-http, to a RemoteData value.
-}
fromResult : Result Error a -> RemoteData a
fromResult result =
  case result of
    Err e ->
      Failure e

    Ok x ->
      Success x


{-| Monoidal append - join two `RemoteData` values together as though
they were one. If both values are Failure, the left one wins.
-}
mappend : RemoteData a -> RemoteData b -> RemoteData ( a, b )
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
