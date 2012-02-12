mongoose = require 'mongoose'
express  = require 'express'
sass     = require 'sass'
fs       = require 'fs'
md       = require 'discount'
yaml     = require 'js-yaml'

app = module.exports = express.createServer()

# Configuration
app.configure ->
  app.use express.cookieParser()
  app.use express.session
    secret: "foo bar baz"
    cookie:
      path: '/'
  app.set 'views', __dirname + '/../views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/../public')
  return


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

# load md file and add a route based on filename
loadMDfiles = (file, prefix) ->
  if file.match("swp") || file.match("gitkee")
    return
  path = "#{prefix}/#{file}"
  fs.readFile "#{__dirname}/../#{prefix}/#{file}", 'utf8', (err,str) ->
    split = str.split('---')
    title = path.replace('md','')
    if split.length > 0
      split.shift() # remove the first
      yamlcontent = split.shift()
      yamlparsed = yaml.load(yamlcontent)
      # set title
      title = yamlparsed.title
      # concatenate the markdown_content
      markdown_content = ''
      markdown_content += s for s in split
      html = md.parse(markdown_content)
    else
      html = md.parse(str)
    routerPath = path.replace('.md','').replace(' ','-')
    routerPath = routerPath.replace('pages/','') if prefix == 'pages'
    app.get "/#{routerPath}", (req, res) ->
      res.render("static", {title:"static page: #{title}", "html":html})

blogPosts = fs.readdirSync "#{__dirname}/../blogposts/"
loadMDfiles blogPost, 'blogposts' for blogPost in blogPosts

pages = fs.readdirSync "#{__dirname}/../pages/"
loadMDfiles f, 'pages' for f in pages


# Routes
routes =
  crafts:require(__dirname+'/routes/crafts')
  session:require(__dirname+'/routes/session')
  users:require(__dirname+'/routes/users')

# start page
app.get '/', (req, res) ->
  res.render "index", title: "welcome"

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
app.get '/signup/flattr', routes.users.signup_flattr
app.get '/flattrusers/:username', routes.users.show_flattruser

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
