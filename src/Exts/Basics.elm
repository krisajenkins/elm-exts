module Exts.Basics exposing (..)

{-| Extensions to the core `Basics` library.

@docs on
@docs compareBy
@docs maxBy
@docs minBy

-}


{-| Run a function on two inputs, before doing something with the
result. Can be useful for things like sorts. For example, `compare
(List.length a) (List.length b)` can be written `on List.length
compare`.

See also `compareBy`.
-}
on : (a -> b) -> (b -> b -> c) -> a -> a -> c
on f g a b =
    g (f a) (f b)


{-| Like `Basics.compare`, with a custom function. For example:

``` elm
compareBy Date.toTime earlyDate laterDate
--> LT
```
-}
compareBy : (a -> comparable) -> a -> a -> Order
compareBy f =
    on f compare


{-| Like `Basics.max`, but it works on non-comparable types by taking a custom function. For example:

``` elm
maxBy Date.toTime earlyDate laterDate
--> laterDate
```
-}
maxBy : (a -> comparable) -> a -> a -> a
maxBy toComparable x y =
    if compareBy toComparable x y == LT then
        y
    else
        x


{-| Like `Basics.min`, but it works on non-comparable types by taking a custom function. For example:

``` elm
minBy Date.toTime earlyDate laterDate
--> earlyDate
```
-}
minBy : (a -> comparable) -> a -> a -> a
minBy toComparable x y =
    if compareBy toComparable x y == LT then
        x
    else
        y
