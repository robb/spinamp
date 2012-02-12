class Spinamp.StaticImage extends Spinamp.Widget
  constructor: (@el, @group, @name, @skin) ->
    super @el

    @el.css
      backgroundImage: 'url(' + @skin.get(@group, @name).toDataURL() + ')'
