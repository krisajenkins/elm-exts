module Exts.Basics exposing (..)

{-| Extensions to the core `Basics` library.

@docs compareBy
@docs maxBy
@docs minBy

-}


{-| Like `Basics.compare`, with a custom function. For example:

``` elm
compareBy Date.toTime earlyDate laterDate
--> LT
```
-}
compareBy : (a -> comparable) -> a -> a -> Order
compareBy f a b =
    compare (f a) (f b)


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
