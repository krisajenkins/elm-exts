module Exts.LatLng exposing (..)

{-| Calculations between points on the earth.

@docs distanceBetween, bearingTo
-}


{-| Calculate the distance in kilometers between two points.

  Note that this assumes the earth is spherical, which is not true, but may be true enough for your purposes.
-}
distanceBetween : { a | latitude : Float, longitude : Float } -> { b | latitude : Float, longitude : Float } -> Float
distanceBetween a b =
    let
        earthRadius =
            6371

        dlat =
            degrees ((b.latitude) - (a.latitude))

        dlng =
            degrees ((b.longitude) - (a.longitude))

        v1 =
            (sin (dlat / 2))
                * (sin (dlat / 2))
                + cos (degrees (a.latitude))
                * cos (degrees (b.latitude))
                * sin (dlng / 2)
                * sin (dlng / 2)

        v2 =
            2 * (atan2 (sqrt v1) (sqrt (1 - v1)))
    in
        earthRadius * v2


{-| Calculate the heading you'd need to travel on to get from point a to point b.
-}
bearingTo : { a | latitude : Float, longitude : Float } -> { b | latitude : Float, longitude : Float } -> Float
bearingTo a b =
    let
        dlon =
            ((degrees b.longitude) - (degrees a.longitude))

        y =
            (sin dlon) * (cos (degrees b.latitude))

        x =
            ((cos (degrees a.latitude)) * (sin (degrees b.latitude))) - ((sin (degrees a.latitude)) * (cos (degrees b.latitude)) * (cos dlon))

        bearing =
            (atan2 y x) * (180 / pi)
    in
        bearing
