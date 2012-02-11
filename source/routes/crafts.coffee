mongoose = module.parent.exports.mongoose
Craft = module.parent.exports.Craft

# GET /crafts
exports.index = (req, res) ->
  crafts = []
  res.render 'crafts/index', {title:"the crafts index", "crafts":crafts}

# GET /crafts/new
exports.new = (req, res) ->
  craft = new Craft
  res.render 'crafts/new', {title: "create a new craft", "craft":craft}

# POST /crafts
exports.create = (req, res) ->
  craft = new Craft
# @todo implement!
  res.render 'crafts/index', {title: "should redirect.."}


