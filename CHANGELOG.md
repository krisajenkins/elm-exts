# CHANGELOG

## Version 28.0.0 -
* Updates for Elm 0.19.
* `Exts.Date` is removed. There have been major changes to Date-representation in Elm 0.19. Read the docs for `elm/time` and consider using it with `rtfeldman/elm-iso8601-date-strings` instead. `Exts.Json.Decode.decodeDate` is removed for the same reasons.

## Version 27.0.0 -
* Removed `Exts.Tuple.mapFirst` and `.mapSecond`. These are in core.

## Version 26.0.0 -

Big breaking changes for Elm 0.18.

* Removed `RemoteData`. This now lives in [its own package][remotedata].
* `Exts.Tuple.first` and `second` become `mapFirst` and `mapSecond`.
[remotedata]: package.elm-lang.org/packages/krisajenkins/remotedata/latest
* Removed most of `Exts.Http`. The new version of `elm-lang/http` is
  much more user-friendly, so few of those supporting functions still
  apply.
