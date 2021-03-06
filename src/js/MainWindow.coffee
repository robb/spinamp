class Spinamp.MainWindow
  constructor: (@el, @skin, callback) ->
    # Set Main window background
    @el.css
      top:  100
      left: 100
      backgroundImage: 'url(' + @skin.get('main', 'window').toDataURL() + ')'

    # Load buttons
    @back    = new Spinamp.Button @el.find('#back'),  @skin, 'back'
    @play    = new Spinamp.Button @el.find('#play'),  @skin, 'play'
    @pause   = new Spinamp.Button @el.find('#pause'), @skin, 'pause'
    @stop    = new Spinamp.Button @el.find('#stop'),  @skin, 'stop'
    @next    = new Spinamp.Button @el.find('#next'),  @skin, 'next'
    @eject   = new Spinamp.Button @el.find('#eject'), @skin, 'eject'
    @shuffle = new Spinamp.ToggleButton @el.find('#shuffle'), @skin, 'shuffle'
    @repeat  = new Spinamp.ToggleButton @el.find('#repeat'),  @skin, 'repeat'

    # no need to wire those up as we can't detect if a track is mono
    @stereo = new Spinamp.StaticImage @el.find('#stereo'),
                                      'monoster',
                                      'stereo_on',
                                      @skin

    @mono = new Spinamp.StaticImage @el.find('#mono'),
                                    'monoster',
                                    'mono_off',
                                    @skin

    @spectrogram = new Spinamp.SpectrogramView @el.find('#spectrogram'), @skin
    @progressBar = new Spinamp.PositionBar @el.find('#progress-bar'), @skin
    @timeView    = new Spinamp.TimeView    @el.find('#time-view'),    @skin
    @titleView   = new Spinamp.TextView @el.find('#title'), @skin

    @kbpsLabel        = new Spinamp.TextView @el.find('#kbps'), @skin
    @kbpsLabel.size   = {width: 20, height: 11}
    @kbpsLabel.origin = {x: 110, y: 41}
    @kbpsLabel.text   = '192'

    @khzLabel        = new Spinamp.TextView @el.find('#khz'), @skin
    @khzLabel.size   = {width: 20, height: 11}
    @khzLabel.origin = {x: 155, y: 41}
    @khzLabel.text   = '44'

    # Layout everything
    @back.size = @play.size = @pause.size = @stop.size = {width: 23, height: 18}
    @next.size = {width: 22, height: 18}

    @eject.size = {width: 22, height: 16}

    @shuffle.size = {width: 47, height: 14}
    @repeat.size  = {width: 27, height: 14}

    @back.origin    = {x:  16, y: 89}
    @play.origin    = {x:  39, y: 89}
    @pause.origin   = {x:  62, y: 89}
    @stop.origin    = {x:  85, y: 89}
    @next.origin    = {x: 108, y: 89}

    @eject.origin   = {x: 136, y: 90}

    @mono.origin  = {x: 209, y: 41}
    @mono.size    = {width: 29, height: 12}

    @stereo.origin  = {x: 236, y: 41}
    @stereo.size    = {width: 29, height: 12}

    @shuffle.origin = {x: 165, y: 91}
    @repeat.origin  = {x: 212, y: 91}

    @progressBar.origin = {x: 16, y: 72}
    @progressBar.size   = {width: 250, height: 10}

    @spectrogram.origin = {x: 24, y: 45}
    @spectrogram.size   = {width: 75, height: 17}

    @timeView.origin = {x: 39, y: 26}
    @timeView.size   = {width: 60, height: 13}

    @titleView.origin = {x: 111, y: 24}
    @titleView.size   = {width: 152, height: 11}

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

    @shuffle.onclick = =>
      Spinamp.Spotify.Player.shuffle = !Spinamp.Spotify.Player.shuffle

    @repeat.onclick = =>
      Spinamp.Spotify.Player.repeat = !Spinamp.Spotify.Player.repeat
