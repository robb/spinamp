class Spinamp.TimeView
  constructor: (@el, @skin) ->
    @canvas  = @el.get(0)
    @canvas.width  = parseInt @el.css 'width'
    @canvas.height = parseInt @el.css 'height'
    @context = @canvas.getContext '2d'

    @el.css
      position: 'absolute'

    Object.defineProperty this, 'origin',
      get: -> origin
      set: (newOrigin) ->
        origin = newOrigin

        @el.css
          left: origin?.x or 0
          top:  origin?.y or 0

    Object.defineProperty this, 'size',
      get: -> size
      set: (newSize) =>
        size = newSize

        @canvas.width  = size.width
        @canvas.height = size.height

        @el.css
          width:  size?.width or 0
          height: size?.height or 0

    position = 0
    Object.defineProperty this, 'position',
      get: -> position
      set: (newPosition) ->
        position = newPosition

        position = ~~(Spinamp.Spotify.Player.position / 1000)
        minutes  = ~~(position / 60)
        seconds  = position % 60

        @context.clearRect 0, 0, @canvas.width, @canvas.height

        # Draw seconds
        if seconds < 10
          @context.drawImage @skin.get('numbers', seconds.toString()),
                             @canvas.width -  9, 0, 9, 13
          @context.drawImage @skin.get('numbers', '0'),
                             @canvas.width - 21, 0, 9, 13
        else
          one = seconds % 10
          ten = ~~(seconds / 10)

          @context.drawImage @skin.get('numbers', one.toString()),
                             @canvas.width -  9, 0, 9, 13
          @context.drawImage @skin.get('numbers', ten.toString()),
                             @canvas.width - 21, 0, 9, 13

        # Draw minutes
        if minutes < 10
          @context.drawImage @skin.get('numbers', minutes.toString()),
                             @canvas.width - 39, 0, 9, 13
          @context.drawImage @skin.get('numbers', '0'),
                             @canvas.width - 51, 0, 9, 13
        else
          one = minutes % 10
          ten = ~~(minutes / 10)

          @context.drawImage @skin.get('numbers', one.toString()),
                             @canvas.width - 39, 0, 9, 13
          @context.drawImage @skin.get('numbers', ten.toString()),
                             @canvas.width - 51, 0, 9, 13
