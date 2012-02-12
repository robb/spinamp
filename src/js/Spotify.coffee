sp      = getSpotifyApi 1
models  = sp.require 'sp://import/scripts/api/models'

Spinamp.Spotify =
  Models:      models
  Player:      models.player
  ChangeEvent: models.EVENT.CHANGE
  TrackPlayer: sp.trackPlayer
