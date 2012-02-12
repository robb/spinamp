class Spinamp.TextView extends Spinamp.Widget
  constructor: (@el, @skin) ->
    super @el

    if @skin.name is 'default'
      @el.css
        color: '#00FF00'

    @el.append @inner = $ '<span></span>'

    text = ''
    Object.defineProperty this, 'text',
      get: -> text
      set: (newText) ->
        text = newText
        @scrollOffset = 0

    scrollOffset = ''
    Object.defineProperty this, 'scrollOffset',
      get: -> scrollOffset
      set: (newScrollOffset) ->
        scrollOffset = newScrollOffset

        start = (scrollOffset + text.length) % text.length

        @inner.html text[start..] #+ ' ' + text[start..]

