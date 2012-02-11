User = module.parent.exports.User

exports.new = (req, res) ->
  res.render 'session/new', {title: "Hello session new"}

