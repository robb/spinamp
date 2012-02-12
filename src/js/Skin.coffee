class Spinamp.Skin
  constructor: (@name, callback) ->
    # Initialize empty sprite store
    @sprites = {}

    assets = 0
    assets++ for own k, v of Spinamp.Skin.Description

    for own group, {file, components} of Spinamp.Skin.Description
      do (group, file, components) =>
        @sprites[group] = {}

        spriteImage = new Image
        spriteImage.onload = =>
          for own name, {origin, size} of components
            do (name, origin, size) =>
              canvas = document.createElement 'canvas'
              [canvas.width, canvas.height] = size
              context = canvas.getContext '2d'

              [width, height] = size
              [    x,      y] = origin

              try
                context.drawImage spriteImage,
                                  x, y, width, height
                                  0, 0, width, height
              catch error
                LOG "Encountered error while loading sprite: #{group}:#{name}"
                LOG "Sprite file may be too small" if error.name is "INDEX_SIZE_ERR"

              @sprites[group][name] = canvas

          callback?() if --assets is 0

        spriteImage.src = "sp://spinamp/skins/#{@name}/#{file}"

  get: (group, name) ->
    unless sprite = @sprites[group]?[name]
      throw "Could not find #{group}:#{name}"
    else
      sprite

  # Describes all assets
  @Description:
    main:
      file: 'Main.gif'
      components:
        window:
          origin: [  0,   0]
          size:   [275, 116]

    buttons:
      file: 'Cbuttons.gif'
      components:
        back:
          origin: [ 0,  0]
          size:   [23, 18]

        back_highlighted:
          origin: [ 0, 18]
          size:   [23, 18]

        play:
          origin: [23,  0]
          size:   [23, 18]

        play_highlighted:
          origin: [23, 18]
          size:   [23, 18]

        pause:
          origin: [46,  0]
          size:   [23, 18]

        pause_highlighted:
          origin: [46, 18]
          size:   [23, 18]

        stop:
          origin: [69,  0]
          size:   [23, 18]

        stop_highlighted:
          origin: [69, 18]
          size:   [23, 18]

        next:
          origin: [92,  0]
          size:   [23, 18]

        next_highlighted:
          origin: [92, 18]
          size:   [23, 18]

        eject:
          origin: [114,  0]
          size:   [ 22, 16]

        eject_highlighted:
          origin: [114, 16]
          size:   [ 22, 16]

    posbar:
      file: 'Posbar.gif'
      components:
        bar:
          origin: [  0,  0]
          size:   [249, 10]

        knob:
          origin: [249,  0]
          size:   [ 30, 10]

        knob_highlighted:
          origin: [277,  0]
          size:   [ 30, 10]

    numbers:
      file: 'Numbers.gif'
      components:
        '0':
          origin: [ 0,  0]
          size:   [ 9, 13]

        '1':
          origin: [ 9,  0]
          size:   [ 9, 13]

        '2':
          origin: [18,  0]
          size:   [ 9, 13]

        '3':
          origin: [27,  0]
          size:   [ 9, 13]

        '4':
          origin: [36,  0]
          size:   [ 9, 13]

        '5':
          origin: [45,  0]
          size:   [ 9, 13]

        '6':
          origin: [54,  0]
          size:   [ 9, 13]

        '7':
          origin: [63,  0]
          size:   [ 9, 13]

        '8':
          origin: [72,  0]
          size:   [ 9, 13]

        '9':
          origin: [81,  0]
          size:   [ 9, 13]

        blank:
          origin: [90,  0]
          size:   [ 9, 13]

    shufflerep:
      file: 'Shufrep.gif'
      components:
        repeat_up_off:
          origin: [ 0,  0]
          size:   [28, 15]

        repeat_down_off:
          origin: [ 0, 15]
          size:   [28, 15]

        repeat_up_on:
          origin: [ 0, 30]
          size:   [28, 15]

        repeat_down_on:
          origin: [ 0, 45]
          size:   [28, 15]

        shuffle_up_off:
          origin: [28,  0]
          size:   [47, 15]

        shuffle_down_off:
          origin: [28, 15]
          size:   [47, 15]

        shuffle_up_on:
          origin: [28, 30]
          size:   [47, 15]

        shuffle_down_on:
          origin: [28, 45]
          size:   [47, 15]
