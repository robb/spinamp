class Spinamp.PositionBar extends Spinamp.Widget
  constructor: (@el, @skin) ->
    super @el

    @knob    = @el.find('#knob')
    @knob.css
      position: 'absolute'
      width:    28
      height:   10

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

    position = undefined
    Object.defineProperty this, 'position',
      get: -> position
      set: (newPosition) ->
        progressBarWidth = parseInt @el.css('width')
        knobWidth        = parseInt @knob.css('width')

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
