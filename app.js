
/**
 * Module dependencies.
 */

var express = require('express')
  , sass = require('sass');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

var routes = {
    pages:require('./routes/pages')
  , callbacks:require('./routes/callbacks')
};

app.get('/', routes.pages.home);
app.get('/about', routes.pages.about);
app.get('/callbacks', routes.callbacks.index);
app.get('/callbacks/flattr', routes.callbacks.flattr);
app.get('/callbacks/justin', routes.callbacks.justin);

app.listen(3000);
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
