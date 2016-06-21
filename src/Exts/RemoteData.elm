module Exts.RemoteData
    exposing
        ( RemoteData(..)
        , WebData
        , fromResult
        , withDefault
        , asCmd
        , append
        , mappend
        , map
        , isSuccess
        , mapFailure
        , mapBoth
        , update
        )

{-| A datatype representing fetched data.

If you find yourself continually using `Maybe (Result Error a)` to
represent loaded data, or you have a habit of shuffling errors away to
where they can be quietly ignored, consider using this. It makes it
easier to represent the real state of a remote data fetch and handle
it properly.

@docs RemoteData, WebData, map, mapFailure, mapBoth, withDefault, fromResult, asCmd, append, mappend, isSuccess, update
-}

import Http
import Task exposing (Task)


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


{-| While `RemoteData` can model any type of error, the most common
one you'll actually encounter is when you fetch data from a REST
interface, and get back `RemoteData Http.Error a`. Because that case
is so common, `WebData` is provided as a useful alias.
-}
type alias WebData a =
    RemoteData Http.Error a


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


{-| Convert a web `Task`, probably produced from elm-http, to a `Cmd (RemoteData e a)`.
-}
asCmd : Task e a -> Cmd (RemoteData e a)
asCmd task =
    Task.perform Failure Success task


{-| Convert a `Result Error`, probably produced from elm-http, to a RemoteData value.
-}
fromResult : Result e a -> RemoteData e a
fromResult result =
    case result of
        Err e ->
            Failure e

        Ok x ->
            Success x


{-| Append - join two `RemoteData` values together as though
they were one.

If their value is `NotAsked`, the result is `NotAsked`.
If their value is `Loading`, the result is `Loading`.
If both values are `Failure`, the left one wins.
-}
append : RemoteData e a -> RemoteData e b -> RemoteData e ( a, b )
append a b =
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


{-| DEPRECATED: Old, incorrect name for `append`.
-}
mappend : RemoteData e a -> RemoteData e b -> RemoteData e ( a, b )
mappend =
    append


{-| State-checking predicate. Returns true if we've successfully loaded some data.
-}
isSuccess : RemoteData e a -> Bool
isSuccess data =
    case data of
        Success x ->
            True

        _ ->
            False


{-| Apply an Elm update function - `Model -> (Model, Cmd Msg)` - to any `Successful`-ly loaded data.

It's quite common in Elm to want to run a model-update function, over
some remote data, but only once it's actually been loaded.

For example, we might want to handle UI messages changing the users
settings, but that only makes sense once those settings have been
returned from the server.

This function makes it more convenient to reach inside a
`RemoteData.Success` value and apply an update. If the data in not
`Success a`, it is return unchanged with a `Cmd.none`.

-}
update : (a -> ( a, Cmd b )) -> RemoteData e a -> ( RemoteData e a, Cmd b )
update f remoteData =
    case remoteData of
        Success data ->
            let
                ( first, second ) =
                    f data
            in
                ( Success first, second )

        _ ->
            ( remoteData, Cmd.none )
