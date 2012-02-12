$ ->
  skin = new Spinamp.Skin 'default', =>
    new Spinamp.MainWindow          $('#main'), skin
    new Spinamp.VisualizationWindow $('#avs'),  skin

  console.log Spinamp
