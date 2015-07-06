module Exts.List where

{-| Extensions to the core List library.

@docs chunk
 -}

import List exposing (take, drop, length)

{-| Split a list into chunks of length n.

  Be aware that the last sub-list may be smaller than n-items long.

  For example `chunk 3 [1,2,3,4,5,6,7,8,9,10] => [[1,2,3], [4,5,6], [7,8,9], [10]]`
-}
chunk : Int -> List a -> List (List a)
chunk n xs =
  if | xs == [] -> []
     | (length xs) > n -> (take n xs) :: (chunk n (drop n xs))
     | otherwise -> [xs]
