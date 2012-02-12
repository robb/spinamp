class Spinamp.VisualizationWindow
  constructor: (@el, @skin) ->
    WIDTH  = 400
    HEIGHT = 400

    @el.css
      position: 'absolute'
      width:    WIDTH
      height:   HEIGHT

      top:      202

    @el.append @topLeft     = $ '<div></div>'
    @el.append @top         = $ '<div></div>'
    @el.append @topRight    = $ '<div></div>'
    @el.append @left        = $ '<div></div>'
    @el.append @right       = $ '<div></div>'
    @el.append @bottomLeft  = $ '<div></div>'
    @el.append @bottom      = $ '<div></div>'
    @el.append @bottomRight = $ '<div></div>'

    @el.append $ @canvas = document.createElement 'canvas'
    @canvas.width  = WIDTH  - 6
    @canvas.height = HEIGHT - 5
    @canvas.top    = 14
    @canvas.left   = 5

    @context = @canvas.getContext '2d'
    @context.globalCompositionOperation = 'lighten'

    @context.beginPath()

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

    @time = 0
    @cameraX = @xT = @xI = -4
    @cameraY = @yT = @yI = -4
    @cameraZ = @zT = @zI = -10
    @frame = 0

    @draw()

  rgbToHsl: (r, g, b) ->
    r /= 0xFF
    g /= 0xFF
    b /= 0xFF

    max = Math.max r, g, b
    min = Math.min r, g, b

    l = (max + min) / 2;

    if max is min
        h = s = 0
    else
        d = max - min

        s = if l > 0.5
          d / (2 - max - min)
        else
          d / (max + min);

        switch max
          when r
            h = (g - b) / d + if g < b then 6 else 0
          when g
            h = (b - r) / d + 2
          when b
            h = (r - g) / d + 4

        h /= 6

    [h, s, l]

  hue2rgb: (p, q, t) ->
    if t < 0
      t += 1
    if t > 1
      t -= 1

    if t < 1/6
      return p + (q - p) * 6 * t
    if t < 1/2
      return q
    if t < 2/3
      return p + (q - p) * (2/3 - t) * 6

    p

  hslToRgb: (h, s, l) ->
    if s is 0
      r = g = b = l
    else
      q =
        if l < 0.5
          l * (1 + s)
        else
          l + s - l * s

      p = 2 * l - q
      r = @hue2rgb p, q, h + 1/3
      g = @hue2rgb p, q, h
      b = @hue2rgb p, q, h - 1/3

    return [~~(r * 255), ~~(g * 255), ~~(b * 255)];


  draw: (data) ->
    if data?
      [R, G, B] = @hslToRgb Math.sin((@time / 25) + Math.PI / 4),
                  0.2 + Math.sqrt(Math.sqrt(data.right_levels[50])) / 8,
                  0.1,
                  0

    else
      [R, G, B] = @hslToRgb Math.sin((@time / 25) + Math.PI / 4),
                  0.5,
                  0.2

    @context.fillStyle = "rgba(#{R}, #{G}, #{B}, 0.5)"

    @context.fillRect 0, 0, @canvas.width, @canvas.height

    return unless data?

    try
      # Based on http://acko.net/blog/js1k-demo-the-making-of/
      @time += Math.sqrt(Math.sqrt(Math.sqrt(data.right_levels[50]))) / 10
      @frame++

      yaw     = 0
      pitch   = 0
      lineWidthFactor = 2

      width  = ~~@canvas.width
      height = ~~@canvas.height
      width_half  = width  >> 2
      height_half = height >> 2

      wires = ~~(8 + Math.sqrt(data.right_levels[50]) * 10)
      bin   = Math.ceil(200 / wires)

      if @frame % 50 is 0
        @xT = Math.random() - 0.5
        @yT = Math.random() - 0.5
        @zT = Math.random() * -5 - 4

      interpolate = (a, b) -> a + (b - a) * 0.01

      @xI = interpolate @xI, @xT
      @yI = interpolate @yI, @yT
      @zI = interpolate @zI, @zT

      @cameraX = interpolate @cameraX, @xT
      @cameraY = interpolate @cameraY, @yT
      @cameraZ = interpolate @cameraZ, @zT

      #yaw   = Math.atan2(@cameraZ, -@cameraX)
      #pitch = Math.atan2(@cameraY, Math.sqrt(@cameraX * @cameraX + @cameraZ * @cameraZ))

      for wireIndex in [0..wires]
        # Start new wire
        for pointIndex in [0..45]
          # Calculate path of point on a sphere
          offset    = @time -
                      pointIndex * 0.03 - wireIndex * 3

          longitude = Math.cos(offset + Math.sin(offset * 0.31)) * 2 +
                      Math.sin(offset * 0.83) * 3 +
                      offset * 0.02

          latitude  = Math.sin(offset * 0.7) -
                      Math.cos(3 + offset * 0.23) * 3

          # Extrude outwards in swooshes
          distance = Math.sqrt(pointIndex - Math.sqrt(Math.sqrt(Math.sqrt(data.right_levels[50]))) / 5)
          x = Math.cos(longitude) * Math.cos(latitude) * distance
          y = Math.sin(longitude) * Math.sin(latitude) * distance
          z = Math.sin(latitude)  * distance

          # Translate and rotate into camera view
          x -= @cameraX
          y -= @cameraY
          z -= @cameraZ

          x2 = x * Math.cos(yaw) + z * Math.sin(yaw)
          y2 = y
          z2 = z * Math.cos(yaw) - x * Math.sin(yaw)

          x3 = x2
          y3 = y2 * Math.cos(pitch) + z2 * Math.sin(pitch)
          z3 = z2 * Math.cos(pitch) - y2 * Math.sin(pitch)

          # Project to 2d
          cX = width  * (x3 / z3) + width_half
          cY = height * (y3 / z3) + height_half

          # Calculate color, width and luminance

          @context.lineTo(cX, cY)
          # If this points is in front of the camera
          if z3 > 0.1
            # If the last point was visible
            if @lastPointVisible
              # Draw line segment
              @context.closePath()

              if pointIndex isnt 0
                @context.lineWidth = Math.sqrt(Math.sqrt(data.left_levels[wireIndex * bin])) * (80 / z3)
              else
                @context.lineWidth = 20

              [r, g, b] = @hslToRgb Math.sin(@time / 25) + ((wireIndex + 2) / (wires * 8)),
                                    0.5 + Math.sqrt(Math.sqrt(data.left_levels[wireIndex * bin])) / 2,
                                    0.5 + Math.sqrt(Math.sqrt(data.left_levels[wireIndex * bin])) / 2,
                                    0

              a = 1 - (pointIndex / 45)

              @context.strokeStyle = "rgba(#{r}, #{g}, #{b}, #{a})"

              @context.stroke()
            else
              @lastPointVisible = yes
          else
            # Mark this point as invisible
            @lastPointVisible = no

          # Mark beginning of new line segment
          @context.beginPath()
          @context.moveTo(cX, cY)
    catch e
      LOG e.message
