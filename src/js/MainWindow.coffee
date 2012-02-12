class Spinamp.MainWindow
  constructor: (@el, callback) ->

    @skin = new Spinamp.Skin 'default', =>
      LOG 'Skin Loaded'

      # Set Main window background
      @el.css
        backgroundImage: 'url(' + @skin.get('main', 'window').toDataURL() + ')'

      # Load buttons
      @back  = new Spinamp.Button @el.find('#back'),    @skin, 'back'
      @play  = new Spinamp.Button @el.find('#play'),    @skin, 'play'
      @pause = new Spinamp.Button @el.find('#pause'),   @skin, 'pause'
      @stop  = new Spinamp.Button @el.find('#stop'),    @skin, 'stop'
      @next  = new Spinamp.Button @el.find('#next'),    @skin, 'next'
      @eject = new Spinamp.Button @el.find('#eject'),   @skin, 'eject'

      # @shuffle = new Spinamp.Button @el.find('shuffle'), @skin, 'shuffle'
      # @repeat  = new Spinamp.Button @el.find('repeat'),  @skin, 'repeat'

      # Set events handlers for buttons
      @back.onclick = =>
        Spinamp.Spotify.Player.previous()

      @play.onclick = =>
        # Restart current track if we're already playing something
        if Spinamp.Spotify.Player.playing
          Spinamp.Spotify.Player.position = 0
        else
          Spinamp.Spotify.Player.playing = yes

      @pause.onclick = =>
        Spinamp.Spotify.Player.playing = !Spinamp.Spotify.Player.playing

      @stop.onclick = =>
        Spinamp.Spotify.Player.playTrack('')

      @next.onclick = =>
        Spinamp.Spotify.Player.next()

      # Set up the spectrogram
      @spectrogram = new Spinamp.SpectrogramView @el.find('#spectrogram'), @skin

      # Overserve FFT event
      Spinamp.Spotify.TrackPlayer.addEventListener 'playerAudioLevelsChanged', (event) =>
        @spectrogram.draw event.data

      # Set up progress bar
      @progressBar = new Spinamp.PositionBar @el.find('#progress-bar'), @skin

      # Poll player position
      pollPosition = =>
        unless Spinamp.Spotify.Player.track
          @progressBar.position = undefined
        else
          duration = Spinamp.Spotify.Player.track.duration
          position = Spinamp.Spotify.Player.position

          @progressBar.position = position / duration

        setTimeout pollPosition, 1000 / 120
      pollPosition()

      # Set up the title text view
      @titleView = new Spinamp.TextView @el.find('#title')

      Spinamp.Spotify.Player.observe Spinamp.Spotify.ChangeEvent, updateTitle = =>
        track = Spinamp.Spotify.Player.track
        @titleView.text = "#{track.artists[0].name} - #{track.name}"

      updateTitle()
