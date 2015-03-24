module Exts.RemoteData where

{-| A replacement to the Http type. It's chief addition is to model the notion of "Not yet requested." |-}

import Json.Decode as Json
import Http (..)

type RemoteData a
  = NotAsked
  | Loading
  | Failed String
  | Answer a

fromHttp : Maybe (Response a) -> RemoteData a
fromHttp response =
  case response of
    Nothing -> NotAsked
    Just Waiting -> Loading
    Just (Failure _ err) -> Failed err
    Just (Success x) -> Answer x

fromFromHttp : Json.Decoder a -> Maybe (Response String) -> RemoteData a
fromFromHttp decoder response =
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
