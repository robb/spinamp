_      = require 'underscore'
fs     = require 'fs'
eco    = require 'eco'
exec   = require('child_process').exec
jade   = require 'jade'
less   = require 'less'
path   = require 'path'
coffee = require 'coffee-script'
colors = require 'colors'
mkdirp = require 'mkdirp'

sourceDir = 'src'
targetDir = 'bin'

log = (string, color = 'green') ->
  console.log string[color]

compile = (dir, watch = off) ->
  group = (file) ->
    fs.statSync(file).isDirectory() and 'dirs' or 'files'

  {dirs, files} = _(fs.readdirSync dir).chain()
    .map((name) -> path.join dir, name)
    .groupBy(group)
    .value()

  mkdirp.sync dir.replace sourceDir, targetDir

  files.forEach (file) ->
    switch path.extname file
      when '.coffee' then apply compileCoffee, file, watch
      when '.eco'    then apply compileEco,    file, watch
      when '.jade'   then apply compileJade,   file, watch
      when '.less'   then apply compileLess,   file, watch
      else
        apply copy, file, watch

  dirs?.map (dir) -> compile dir, watch

apply = (f, file, watch = off) ->
  f file

  if watch
    log "Watching #{file}", 'yellow'
    fs.watchFile file, (curr, prev) ->
      f file if +curr.mtime isnt +prev.mtim

compileCoffee = (file) ->
  log "Compiling #{file}"

  outputFile = file.replace(sourceDir, targetDir).replace /\.coffee$/, '.js'
  javaScript = fs.readFileSync file, 'utf8'

  fs.writeFileSync outputFile, coffee.compile javaScript

compileEco = (file) ->
  log "Compiling #{file}"

  outputFile = file.replace(sourceDir, targetDir).replace /\.eco$/, '.html'
  template   = fs.readFileSync file, 'utf8'

  fs.writeFileSync outputFile, eco.render template

compileJade = (file) ->
  log "Compiling #{file}"

  outputFile = file.replace(sourceDir, targetDir).replace /\.jade$/, '.html'
  template   = fs.readFileSync file, 'utf8'

  try
    fs.writeFileSync outputFile, jade.compile(template)()
  catch error
    log error, 'error'

compileLess = (file) ->
  log "Compiling #{file}"

  outputFile = file.replace(sourceDir, targetDir).replace /\.less$/, '.css'
  stylesheet = fs.readFileSync file, 'utf8'

  less.render stylesheet, (e, css) ->
    fs.writeFileSync outputFile, css

copy = (file) ->
  log "Copying #{file}"

  targetFile = file.replace sourceDir, targetDir

  src = fs.createReadStream  file
  dst = fs.createWriteStream targetFile

  dst.once 'open', -> src.pipe dst

task 'build', ->
  compile sourceDir

task 'watch', ->
  compile sourceDir, yes
