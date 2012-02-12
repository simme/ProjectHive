mongoose = require 'mongoose'
User = mongoose.model 'User'

# GET /users
exports.index = (req, res) ->
  User.find {}, (err, users) ->
    res.render 'users/index', {title:"the users index", "users":users}

# GET /users/new
exports.new = (req, res) ->
  console.log req.session
  user = new User
  if req.session.user
    user.name = req.session.user.username
    user.flattr.username = user.name
  res.render 'users/new',
    title: "create user"
    user: user

# POST /users
exports.create = (req, res) ->
  #user = new User(req.body)
  user = new User(req.body)
  user.save (err) ->
    if err
      res.render 'users/new',
        title:  "crete user | validation errors"
        errors: err
        user:   user
    else
      res.redirect '/users/?created=TRUE'
###

#
# Signup
#
# Displays connect buttons to new users.
#
exports.signup = (req, res) ->
  config = require './../../config.json'
  {Flattr} = require 'flattrjs'
  client = new Flattr
    key: config.api.client_id
    secret: config.api.secret
    client: 'NodeHTTP'

  scopes = ['flattr', 'thing', 'extendedread']
  res.render 'users/signup',
    title: 'Signup',
    url: client.authenticate scopes

#
# Handle flattr callback
#
exports.signup_flattr = (req, res) ->
  code = req.param('code')

  config = require './../../config.json'
  {Flattr} = require 'flattrjs'
  client = new Flattr
    key: config.api.client_id
    secret: config.api.secret
    client: 'NodeHTTP'

  client.getAccessToken code, (err, data) ->
    # todo: probably add some fancy error reportin here...
    if err then throw err

    # Store access_token in session
    req.session.flattr =
          access_token: data.access_token

    # Load current user from flattr
    client.options.access_token = data.access_token
    client.currentUser (err, data) ->
      req.session.user = data
      res.redirect '/users/new'
