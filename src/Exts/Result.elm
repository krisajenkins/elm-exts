module Exts.Result where

{-| Extensions to the core Result library.

@docs bimap, isOk, isErr, resultWithDefault
-}

{-| Treat Result as a bifunctor. -}
bimap : (e -> f) -> (a -> b)  -> Result e a -> Result f b
bimap f g r =
  case r of
    Ok x -> Ok (g x)
    Err x -> Err (f x)

{-| Boolean checks for success/failure. -}
isOk : Result a b -> Bool
isOk x =
  case x of
    Ok _ -> True
    Err _ -> False

{-|-}
isErr : Result a b -> Bool
isErr = not << isOk

{-| Like Maybe.withDefault, for Results.-}
resultWithDefault : b -> Result a b ->  b
resultWithDefault d x =
  case x of
    Ok y -> y
    Err _ -> d
