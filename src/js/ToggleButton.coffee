class Spinamp.ToggleButton
  constructor: (@el, @skin, name) ->
    down  = no
    state = off

    updateCSS = =>
      key =
        if down and state
          "#{name}_down_on"
        else if down and not state
          "#{name}_down_off"
        else if not down and state
          "#{name}_up_on"
        else if not down and not state
          "#{name}_up_off"

      @el.css 'backgroundImage',
              'url(' + @skin.get('shufflerep', key).toDataURL() + ')'

    Object.defineProperty this, 'down',
      get: -> down
      set: (pressed) ->
        down = pressed
        updateCSS()

    Object.defineProperty this, 'state',
      get: -> state
      set: (newState) ->
        state = newState
        updateCSS()

    @down  = no
    @state = off

    # Set up mouse events
    resetButton = =>
        $('body').unbind 'mouseup', resetButton

        @down = no
        off

    @el.bind 'mousedown', =>
      $(document).bind 'mouseup', resetButton

      @down = yes
      off

    @el.bind 'mouseup', =>
      $(document).unbind 'mouseup', resetButton

      @down = no

      @onclick?()

      off
