class Spinamp.Widget
  constructor: (@el) ->
    origin = {x: 0, y: 0}
    size   = {width: 0, height: 0}

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
      set: (newSize) ->
        size = newSize

        @el.css
          width:  size?.width or 0
          height: size?.height or 0

    @origin = {x: 0, y: 0}
    @size   = {width: 0, height: 0}
