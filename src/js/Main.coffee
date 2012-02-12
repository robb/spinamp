$ ->
  skin = new Spinamp.Skin 'default', =>
    main = new Spinamp.MainWindow          $('#main'), skin
    avs  = new Spinamp.VisualizationWindow $('#avs'),  skin

        # Overserve FFT event
    Spinamp.Spotify.TrackPlayer.addEventListener 'playerAudioLevelsChanged', (event) =>
      main.spectrogram.draw event.data
      avs.draw              event.data

    # Poll player position
    pollPosition = =>
      unless Spinamp.Spotify.Player.track
        main.progressBar.position = undefined
      else
        duration = Spinamp.Spotify.Player.track.duration
        position = Spinamp.Spotify.Player.position

        main.timeView.position    = position
        main.progressBar.position = position / duration

      setTimeout pollPosition, 1000 / 120
    pollPosition()

    Spinamp.Spotify.Player.observe Spinamp.Spotify.ChangeEvent, updatePlayer = =>
      track = Spinamp.Spotify.Player.track

      unless track
        main.spectrogram.draw()
        avs.draw()

      main.repeat.state  = Spinamp.Spotify.Player.repeat
      main.shuffle.state = Spinamp.Spotify.Player.shuffle

      main.titleView.text = "#{track.artists[0].name} - #{track.name}"

    updatePlayer()


  console.log Spinamp
