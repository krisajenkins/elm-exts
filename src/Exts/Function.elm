module Exts.Function exposing (..)

{-| Extensions so generic they just operate on functions.

@docs (>>>)
@docs (<<<)
-}


{-| Left-to-right composition of functions that rely on an environment.

Example:

    quux (bar (foo model x) model) model

Becomes:

    (foo >>> bar >>> quux) model x

The operator `>>>` mirrors Haskell's Control.Arrow, because really
this is an arrow specialised to Reader.
-}
(>>>) : (env -> a -> b) -> (env -> b -> c) -> (env -> a -> c)
(>>>) f g env =
    f env >> g env


{-| Right-to-left composition of functions that rely on an environment.
-}
(<<<) : (env -> b -> c) -> (env -> a -> b) -> (env -> a -> c)
(<<<) f g env =
    f env << g env
