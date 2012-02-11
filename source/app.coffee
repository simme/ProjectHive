
express = require('express')
sass    = require('sass')

app = module.exports = express.createServer()

# Configuration

app.configure ->
  app.set('views', __dirname + '/../views')
  app.set('view engine', 'jade')
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(__dirname + '/../public'))

app.configure 'development', () ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
app.configure 'production', () ->
  app.use(express.errorHandler())

# Routes

routes =
  pages:require(__dirname + '/routes/pages')
  callbacks:require(__dirname + '/routes/callbacks')

app.get '/', routes.pages.home
app.get '/about', routes.pages.about
app.get '/callbacks', routes.callbacks.index
app.get '/callbacks/flattr', routes.callbacks.flattr
app.get '/callbacks/justin', routes.callbacks.justin

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
