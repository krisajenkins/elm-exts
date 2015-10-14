module Exts.Routing
       (Route, matchRoutes)
       where

{-| An experimental routing library.

Note: When this ceases to be experimental, it will probably be split into its own package.

@docs matchRoutes, Route

-}

import String exposing (startsWith)
import Exts.String exposing (removePrefix)

{-| A route is a pair of (the string prefix to match on, a function
that turns the suffix into the type you're parsing for. -}
type alias Route a = (String, String -> Maybe a)

{-| Given a list of routes, find the first that matches the prefix
string. Pass the remainer of the string to the route function to get a
result.

Example:

```
type View
  = BlogPost String
  | FrontPage

routes : List (String, String -> Maybe View)
routes = [("blogpost/", Just << BlogPost)
         ,("", always (Just FrontPage))]

> matchRoutes routes "blogpost/hello"
  => Just (BlogPost "hello")

```


-}
matchRoutes : List (Route a) -> String -> Maybe a
matchRoutes routes uri =
  List.filterMap (matchRoute uri) routes
    |> List.head

matchRoute : String -> Route a -> Maybe a
matchRoute uri (prefix, handler) =
  if startsWith prefix uri
  then handler (removePrefix prefix uri)
  else Nothing
