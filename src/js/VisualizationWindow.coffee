class Spinamp.VisualizationWindow
  constructor: (@el, @skin) ->
    @el.css
      position: 'absolute'
      width:    275
      height:   275

      top:      202

    @el.append @topLeft     = $ '<div></div>'
    @el.append @top         = $ '<div></div>'
    @el.append @topRight    = $ '<div></div>'
    @el.append @left        = $ '<div></div>'
    @el.append @right       = $ '<div></div>'
    @el.append @bottomLeft  = $ '<div></div>'
    @el.append @bottom      = $ '<div></div>'
    @el.append @bottomRight = $ '<div></div>'

    @canvas = document.createElement 'canvas'
    @canvas.width  = 250
    @canvas.height = 250
    @context = @canvas.getContext '2d'

    @topLeft.css
      position: 'absolute'
      top:      0
      left:     0
      width:    50
      height:   15
      background: 'url(' + @skin.get('avs', 'border_top_left').toDataURL() + ')'

    @top.css
      position: 'absolute'
      top:      0
      left:     50
      right:    16
      height:   15
      background: 'url(' + @skin.get('avs', 'border_top').toDataURL() + ')'

    @topRight.css
      position: 'absolute'
      top:      0
      right:    0
      width:    16
      height:   15
      background: 'url(' + @skin.get('avs', 'border_top_right').toDataURL() + ')'

    @left.css
      position: 'absolute'
      top:      15
      bottom:   5
      left:     0
      width:    7
      background: 'url(' + @skin.get('avs', 'border_left').toDataURL() + ')'
      backgroundSize: '6px 100%'

    @right.css
      position: 'absolute'
      top:      15
      right:    0
      bottom:   5
      width:    6
      backgroundImage: 'url(' + @skin.get('avs', 'border_right').toDataURL() + ')'
      backgroundSize: '6px 100%'

    @bottomLeft.css
      position: 'absolute'
      left:     0
      bottom:   0
      width:    50
      height:   5
      background: 'url(' + @skin.get('avs', 'border_bottom_left').toDataURL() + ')'

    @bottom.css
      position: 'absolute'
      left:     50
      bottom:   0
      right:    16
      height:   5
      backgroundImage: 'url(' + @skin.get('avs', 'border_bottom').toDataURL() + ')'
      backgroundSize: '100% 5px'

    @bottomRight.css
      position: 'absolute'
      bottom:   0
      right:    0
      width:    16
      height:   5
      background: 'url(' + @skin.get('avs', 'border_bottom_right').toDataURL() + ')'

    @draw()

  draw: (data) ->
    @context.fillRect 0, 0, @canvas.width, @canvas.height

    @el.css 'backgroundImage', 'url(' + @canvas.toDataURL() + ')'
