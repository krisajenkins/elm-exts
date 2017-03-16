module Exts.Result exposing (..)

{-| Extensions to the core `Result` library.

@docs mapBoth
@docs isOk
@docs isErr
@docs fromOk
@docs fromErr
@docs mappend
@docs either
-}


{-| Apply functions to both sides of a `Result`, transforming the error and ok types.
-}
mapBoth : (e -> f) -> (a -> b) -> Result e a -> Result f b
mapBoth f g r =
    case r of
        Ok x ->
            Ok (g x)

        Err x ->
            Err (f x)


{-| Boolean checks for success/failure.
-}
isOk : Result e a -> Bool
isOk x =
    case x of
        Ok _ ->
            True

        Err _ ->
            False


{-| -}
isErr : Result e a -> Bool
isErr =
    not << isOk


{-| Convert a `Result` to a `Maybe`.
-}
fromOk : Result e a -> Maybe a
fromOk x =
    case x of
        Ok x ->
            Just x

        Err _ ->
            Nothing


{-| -}
fromErr : Result e a -> Maybe e
fromErr x =
    case x of
        Err x ->
            Just x

        Ok _ ->
            Nothing


{-| Monoidal append - join two Results together as though they were one.
-}
mappend : Result e a -> Result e b -> Result e ( a, b )
mappend a b =
    case ( a, b ) of
        ( Err x, _ ) ->
            Err x

        ( _, Err y ) ->
            Err y

        ( Ok x, Ok y ) ->
            Ok ( x, y )


{-| Collapse a `Result` down to a single value of a single type.

Example:

``` elm
  case result of
    Err err -> errorView err
    Ok value -> okView value
```

...is equivalent to:

``` elm
  either errorView okView result
```
-}
either : (e -> c) -> (a -> c) -> Result e a -> c
either f g r =
    case r of
        Err x ->
            f x

        Ok x ->
            g x
