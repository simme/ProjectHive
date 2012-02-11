mongoose = require 'mongoose'
express  = require 'express'
sass     = require 'sass'
fs       = require 'fs'

app = module.exports = express.createServer()

# Configuration

app.configure ->
  app.set 'views', __dirname + '/../views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/../public')

app.configure 'development', () ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', () ->
  app.use express.errorHandler()

# Data store
mongoose.connect 'mongodb://localhost/projecthive'

# Automagically load models
loadModel = (file) ->
  require "./models/#{file}"
fs.readdir "#{__dirname}/models", (err, files) =>
  if err then throw err
  loadModel file for file in files
  console.log mongoose.model 'User'

# Routes
routes =
  pages:require(__dirname + '/routes/pages')
  callbacks:require(__dirname + '/routes/callbacks')
  crafts:require(__dirname+'/routes/crafts')
  session:require(__dirname+'/routes/session')
  users:require(__dirname+'/routes/users')

# pages
app.get '/', routes.pages.home
app.get '/about', routes.pages.about
# callbacks
app.get '/callbacks', routes.callbacks.index
app.get '/callbacks/flattr', routes.callbacks.flattr
app.get '/callbacks/justin', routes.callbacks.justin
# crafts
app.get '/crafts', routes.crafts.index
app.get '/crafts/new', routes.crafts.new
app.post '/crafts', routes.crafts.create
# session
app.get '/session/new', routes.session.new
app.get '/session/check', routes.session.check
# users
app.get '/users/new', routes.users.new
app.get '/users', routes.users.index
app.post '/users', routes.users.create

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
