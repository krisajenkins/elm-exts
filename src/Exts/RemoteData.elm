module Exts.RemoteData where

import Json.Decode as Json
import Http (..)

type RemoteData a
  = NotAsked
  | Loading
  | Failed String
  | Answer a

-- TODO Rename
foo : Maybe (Response a) -> RemoteData a
foo response =
  case response of
    Nothing -> NotAsked
    Just Waiting -> Loading
    Just (Failure _ err) -> Failed err
    Just (Success x) -> Answer x

-- TODO Rename
bar : Json.Decoder a -> Maybe (Response String) -> RemoteData a
bar decoder response =
  case response of
    Nothing -> NotAsked
    Just Waiting -> Loading
    Just (Failure _ err) -> Failed err
    Just (Success x) -> case (Json.decodeString decoder x) of
                          Err err -> Failed err
                          Ok x -> Answer x

map : ( a -> b ) -> RemoteData a -> RemoteData b
map f d =
  case d of
    NotAsked -> NotAsked
    Loading -> Loading
    Failed s -> Failed s
    Answer a -> Answer (f a)
