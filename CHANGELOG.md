# CHANGELOG

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
