mongoose = require 'mongoose'
express  = require 'express'
sass     = require 'sass'
fs       = require 'fs'
md       = require 'discount'

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
files = fs.readdirSync "#{__dirname}/models"
loadModel file for file in files

loadMDfiles = (file, prefix) ->
  path = "#{prefix}/#{file}"
  fs.readFile "#{__dirname}/../#{prefix}/#{file}", 'utf8', (err,str) ->
    html = md.parse(str)
    routerPath = path.replace('.md','').replace(' ','-')
    routerPath = routerPath.replace('pages/','') if prefix == 'pages'
    app.get "/#{routerPath}", (req, res) ->
      res.send(html)

blogPosts = fs.readdirSync "#{__dirname}/../blogposts"
loadMDfiles blogPost, 'blogposts' for blogPost in blogPosts

pages = fs.readdirSync "#{__dirname}/../pages"
loadMDfiles f, 'pages' for f in pages


# Routes
routes =
  callbacks:require(__dirname + '/routes/callbacks')
  crafts:require(__dirname+'/routes/crafts')
  session:require(__dirname+'/routes/session')
  users:require(__dirname+'/routes/users')

# pages
app.get '/', (req, res) ->
  res.render "index", title: "welcome"

# callbacks
app.get '/callbacks', routes.callbacks.index
app.get '/callbacks/flattr', routes.callbacks.flattr
app.get '/callbacks/justin', routes.callbacks.justin

# crafts
app.get '/crafts', routes.crafts.index
app.get '/crafts/new', routes.crafts.new_form
app.get "/crafts/:craft_id", routes.crafts.show
app.post '/crafts', routes.crafts.create

# session
app.get '/session/new', routes.session.new
app.get '/session/check', routes.session.check

# users
app.get '/users/new', routes.users.new
app.get '/users', routes.users.index
app.post '/users', routes.users.create
app.get '/signup', routes.users.signup

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
