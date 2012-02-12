class Spinamp.PositionBar
  constructor: (@el, @skin) ->
    @knob    = @el.find('#knob')

    state    = off
    Object.defineProperty this, 'state',
      get: -> state
      set: (newState) ->
        if state = newState
          @knob.css 'backgroundImage',
                    'url(' + @skin.get('posbar', 'knob_highlighted').toDataURL() + ')'
        else
          @knob.css 'backgroundImage',
                    'url(' + @skin.get('posbar', 'knob').toDataURL() + ')'

    progressBarWidth = parseInt @el.css('width')
    knobWidth        = parseInt @knob.css('width')

    position = undefined
    Object.defineProperty this, 'position',
      get: -> position
      set: (newPosition) ->
        unless (position = newPosition)?
          @knob.css
            display: 'none'
        else
          @knob.css
            display: 'block'
            left:    ~~(position * (progressBarWidth - knobWidth))

    @position = undefined
    @state    = off

    @knob.bind 'mousedown', =>
      @state = on

    @knob.bind 'mouseup', =>

      @state = off
      @onclick?()
