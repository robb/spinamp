class Spinamp.SpectrogramView
  constructor: (@el, @skin) ->
    @peakColor = 0x9393A3
    @meters = [
      # bright red
      '#CF6D29',
      '#CF6D29',
      '#CF6D29',
      '#CF6D29',
      # yellow
      '#E0CD30',
      '#E0CD30',
      '#E0CD30',
      '#E0CD30',
      '#E0CD30',
      # green
      '#30AD15',
      '#30AD15',
      '#30AD15',
      '#30AD15',
      '#30AD15',
    ]
    @canvas  = @el.get(0)
    @canvas.width  = parseInt @el.css 'width'
    @canvas.height = parseInt @el.css 'height'
    @context = @canvas.getContext '2d'

    @context.fillStyle = 'white'

    @gradient = document.createElement 'canvas'
    @gradient.width  = 3
    @gradient.height = 15
    gradientContext = @gradient.getContext '2d'

    for color, index in @meters
      do (color, index) ->
        gradientContext.fillStyle = color
        gradientContext.fillRect 0, index, 3, 1

  draw: (levels) ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

    return unless levels

    for i in [0..18] by 1
      level = levels.left_levels[i * 13]

      barHeight = ~~(15 * Math.sqrt(Math.sqrt(level)))

      @context.drawImage @gradient,
                         0,     15 - barHeight, 3, barHeight,
                         i * 4, 15 - barHeight, 3, barHeight
