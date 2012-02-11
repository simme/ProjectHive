mongoose = module.parent.exports.mongoose
User = module.parent.exports.User

# GET /users
exports.index = (req, res) ->
  users = []
  query = User.find()
  query.exec (err, obj) ->
    users.push obj
    console.log obj
  res.render 'users/index', {title: "list of users", "users":users}

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
    r = user.save 
    console.log("saved returned: "+r)

