module Exts.Maybe exposing (..)

{-| Extensions to the core `Maybe` library.

@docs isJust
@docs isNothing
@docs maybe
@docs mappend
@docs catMaybes
@docs join
@docs maybeDefault
@docs matches
@docs validate
@docs when
@docs oneOf
-}

import Maybe exposing (withDefault)


{-| Boolean checks.
-}
isJust : Maybe a -> Bool
isJust x =
    case x of
        Just _ ->
            True

        _ ->
            False


{-| -}
isNothing : Maybe a -> Bool
isNothing =
    not << isJust


{-| Apply a function to a value, returning the default if the value is `Nothing`.

Example:

``` elm
greeting : Maybe User -> String
greeting maybeUser =
  case maybeUser of
    Just user -> user.name
    Nothing -> "Guest"
```

...could be replaced with:

``` elm
greeting : Maybe User -> String
greeting user = maybe "Guest" .name user
```

...or even:

``` elm
greeting : Maybe User -> String
greeting = maybe "Guest" .name
```


_Aside: There's always a judgement call to be made here. Is shorter
code clearer (because it removes common plumbing, leaving only
meaning), or is it harder to understand (because people can't see how
the plumbing works anymore)?  Learn both ways, choose with your eyes
open, and stay tasteful out there._

-}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default f =
    withDefault default << Maybe.map f


{-| Join two `Maybe`s together as though they were one.
-}
mappend : Maybe a -> Maybe b -> Maybe ( a, b )
mappend a b =
    case ( a, b ) of
        ( Nothing, _ ) ->
            Nothing

        ( _, Nothing ) ->
            Nothing

        ( Just x, Just y ) ->
            Just ( x, y )


{-| Extract all the `Just` values from a List of Maybes.
-}
catMaybes : List (Maybe a) -> List a
catMaybes =
    List.filterMap identity


{-| Join together two `Maybe` values using the supplied function. If
either value is `Nothing`, the result is `Nothing`.
-}
join : (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
join f left right =
    case ( left, right ) of
        ( Just x, Just y ) ->
            Just (f x y)

        _ ->
            Nothing


{-| If `x` is a `Just _` value, return it, otherwise return `Just default`.
-}
maybeDefault : a -> Maybe a -> Maybe a
maybeDefault default x =
    case x of
        Just x ->
            Just x

        Nothing ->
            Just default


{-| Validate a value against a predicate, returning a `Maybe`.

    validate isEven 2 => Just 2
    validate isEven 3 => Nothing
-}
validate : (a -> Bool) -> a -> Maybe a
validate predicate value =
    if predicate value then
        Just value
    else
        Nothing


{-| Check the if value in the `Maybe` matches a predicate. If it does, pass it through, if not, return nothing.

    matches isEven (Just 2) => Just 2
    matches isEven (Just 3) => Nothing
    matches isEven Nothing => Nothing
-}
matches : (a -> Bool) -> Maybe a -> Maybe a
matches predicate =
    Maybe.andThen (validate predicate)


{-| When `test` returns true, return `Just value`, otherwise return `Nothing`.
-}
when : Bool -> a -> Maybe a
when test value =
    if test then
        Just value
    else
        Nothing


{-| Return the first non-`Nothing` entry in the list.
-}
oneOf : List (Maybe a) -> Maybe a
oneOf =
    List.foldl
        (\x acc ->
            if acc /= Nothing then
                acc
            else
                x
        )
        Nothing
