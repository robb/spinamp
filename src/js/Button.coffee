class Spinamp.Button extends Spinamp.Widget
  constructor: (@el, @skin, name) ->
    super @el

    down = no

    Object.defineProperty this, 'down',
      get: -> down
      set: (pressed) ->
        if down = pressed
          @el.css 'backgroundImage',
                  'url(' + @skin.get('buttons', "#{name}_highlighted").toDataURL() + ')'
        else
          @el.css 'backgroundImage',
                  'url(' + @skin.get('buttons', name).toDataURL() + ')'

    @down = no

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
