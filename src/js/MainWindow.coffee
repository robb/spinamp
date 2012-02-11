class Spinamp.MainWindow
  constructor: (@el, callback) ->

    @skin = new Spinamp.Skin 'default', =>
      LOG 'Skin Loaded'

      # Set Main window background
      @el.css
        backgroundImage: 'url(' + @skin.get('main', 'window').toDataURL() + ')'

      # Load buttons
      @back    = new Spinamp.Button @el.find('#back'),    @skin, 'back'
      @play    = new Spinamp.Button @el.find('#play'),    @skin, 'play'
      @pause   = new Spinamp.Button @el.find('#pause'),   @skin, 'pause'
      @stop    = new Spinamp.Button @el.find('#stop'),    @skin, 'stop'
      @next    = new Spinamp.Button @el.find('#next'),    @skin, 'next'
      @eject   = new Spinamp.Button @el.find('#eject'),   @skin, 'eject'

      # @shuffle = new Spinamp.Button @el.find('shuffle'), @skin, 'shuffle'
      # @repeat  = new Spinamp.Button @el.find('repeat'),  @skin, 'repeat'
