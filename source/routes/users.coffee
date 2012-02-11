mongoose = require 'mongoose'
User = mongoose.model 'User'

# GET /users
exports.index = (req, res) ->
  User.find {}, (err, users) ->
    res.render 'users/index', {title:"the users index", "users":users}

# GET /users/new
exports.new = (req, res) ->
  user = new User
  res.render 'users/new', {title: "create user", "user":user}

# POST /users
exports.create = (req, res) ->
  console.log "PARAMS: name=>"+req.param('name')
  user = new User
  user.name = req.param('name')
  if (user.name!= "")
    console.log("should be able to save "+user)
    user.save ->
      res.redirect '/users/?created'

