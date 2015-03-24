module Exts.List where

import List (..)

chunk : Int -> List a -> List (List a)
chunk n xs =
  if | xs == [] -> []
     | (length xs) > n -> (take n xs) :: (chunk n (drop n xs))
     | otherwise -> [xs]
