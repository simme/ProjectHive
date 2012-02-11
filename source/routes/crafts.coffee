mongoose = require 'mongoose'
Craft = mongoose.model 'Craft'

# GET /crafts
exports.index = (req, res) ->
  Craft.find {}, (err, crafts) ->
    res.render 'crafts/index', {title:"the crafts index", "crafts":crafts}

# GET /crafts/new
exports.new = (req, res) ->
  craft = new Craft
  res.render 'crafts/new', {title: "create a new craft", "craft":"foo"}

# POST /crafts
exports.create = (req, res) ->
  craft = new Craft
# @todo implement!
  craft.title = req.param('title')
  console.log "will save craft object"+craft
  craft.save ->
    res.redirect '/crafts?woot success'


