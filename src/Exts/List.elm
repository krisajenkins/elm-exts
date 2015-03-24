module Exts.List where

{-| Extensions to the core List library. |-}

import List (..)

chunk : Int -> List a -> List (List a)
chunk n xs =
  if | xs == [] -> []
     | (length xs) > n -> (take n xs) :: (chunk n (drop n xs))
     | otherwise -> [xs]
