class Spinamp.Button
  constructor: (@el, @skin, name) ->
    state = off

    Object.defineProperty this, 'state',
      get: -> state
      set: (newState) ->
        if state = newState
          @el.css 'backgroundImage',
                  'url(' + @skin.get('buttons', "#{name}_highlighted").toDataURL() + ')'
        else
          @el.css 'backgroundImage',
                  'url(' + @skin.get('buttons', name).toDataURL() + ')'

    @state = off

    @el.bind 'mousedown', =>
      @state = on

    @el.bind 'mouseup', =>
      @state = off
      @onlick?()
