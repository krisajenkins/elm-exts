module Exts.Tuple where

{-| Extensions for tuples. |-}

indexedPair : (a -> b) -> a -> (b,a)
indexedPair f x = (f x, x)
