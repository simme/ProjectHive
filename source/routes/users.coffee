utils = require('util')
mongoose = require 'mongoose'
User = mongoose.model 'User'

# GET /users
exports.index = (req, res) ->
  User.find {}, (err, users) ->
    res.render 'users/index', {title:"the users index", "users":users}

# GET /flattrusers/:username
# this is just an internal debugging method
exports.show_flattruser = (req, res) ->
  flattr_username = req.param 'username'
  console.log "will show our flattr user #{flattr_username}"
  result = []
  User.findOne {flattr:{username:flattr_username}}, (err, user) ->
    if user
      console.log "found user: #{user}"
    else
      console.log "no user and no error"
  res.send("em")


# GET /users/new
exports.new = (req, res) ->
  console.log req.session
  user = new User
  if req.session.new_user
    user.name = req.session.new_user.username
    user.flattr.username = user.name
  res.render 'users/new',
    title: "create user"
    user: user

# POST /users
exports.create = (req, res) ->
  if req.session.user_id
    res.redirect '/users?you are already logged; cant create a new user'
    return
  
  user = new User(req.body)
  user.save (err) ->
    if err
      res.render 'users/new',
        title:  "crete user | validation errors"
        errors: err
        user:   user
    else
      res.redirect '/users/?created=TRUE'

#
# Signup
#
# Displays connect buttons to new users.
#
exports.signup = (req, res) ->
  config = require './../../config.json'
  {Flattr} = require 'flattrjs'
  client = new Flattr
    key: config.api.flattr.client_id
    secret: config.api.flattr.secret
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
    key: config.api.flattr.client_id
    secret: config.api.flattr.secret
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
      if data
        # are the flattr user already in our db?
        User.findOne {flattr:{username:data.username}}, (err, user) ->
          # if it is, the session is considered authenticated
          if user
            req.session.user_id = user._id
            res.redirect '/?logged_in'
          # else; tell the guest to create a user
          else
            req.session.new_user = data
            res.redirect '/users/new?create_new_please'
      else
        res.redirect '/users/signup?failed to fetch flattr user'
