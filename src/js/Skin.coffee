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
          for name, {origin, size} of components
            canvas = document.createElement 'canvas'
            canvas.width  = size.width
            canvas.height = size.height
            context = canvas.getContext '2d'

            try
              context.drawImage spriteImage,
                                origin.x, origin.y, size.width, size.height
                                       0,        0, size.width, size.height
            catch error
              LOG "Encountered error while loading sprite: #{group}:#{name}"
              LOG "Sprite file may be too small" if error.name is "INDEX_SIZE_ERR"
              break

            callback?() if --assets is 0

        spriteImage.src = "sp://spinamp/skins/#{@name}/#{file}"

  getSprite: (group, name) ->
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
          size:   [22, 18]

        back_highlighted:
          origin: [ 0, 18]
          size:   [22, 18]

        play:
          origin: [23,  0]
          size:   [22, 18]

        play_highlighted:
          origin: [23, 18]
          size:   [22, 18]

        pause:
          origin: [46,  0]
          size:   [22, 18]

        pause_highlighted:
          origin: [46, 18]
          size:   [22, 18]

        stop:
          origin: [69,  0]
          size:   [22, 18]

        stop_highlighted:
          origin: [69, 18]
          size:   [22, 18]

        forward:
          origin: [92,  0]
          size:   [22, 18]

        forward_highlighted:
          origin: [92, 18]
          size:   [22, 18]

        eject:
          origin: [114,  0]
          size:   [ 22, 16]

        eject_highlighted:
          origin: [114, 16]
          size:   [ 22, 16]





