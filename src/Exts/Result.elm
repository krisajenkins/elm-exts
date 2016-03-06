module Exts.Result (..) where

{-| Extensions to the core Result library.

@docs bimap, isOk, isErr, mappend
-}


{-| Treat `Result` as a bifunctor, applying the first function to `Err` values and the second to `Ok` ones.
-}
bimap : (e -> f) -> (a -> b) -> Result e a -> Result f b
bimap f g r =
  case r of
    Ok x ->
      Ok (g x)

    Err x ->
      Err (f x)


{-| Boolean checks for success/failure.
-}
isOk : Result a b -> Bool
isOk x =
  case x of
    Ok _ ->
      True

    Err _ ->
      False


{-| -}
isErr : Result a b -> Bool
isErr =
  not << isOk


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
