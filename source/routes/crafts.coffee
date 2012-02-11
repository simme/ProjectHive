mongoose = require 'mongoose'
Craft = mongoose.model 'Craft'

module.exports =
  # GET /crafts
  index : (req, res) ->
    Craft.find {}, (err, crafts) ->
      res.render 'crafts/index', {title:"the crafts index", "crafts":crafts}

  # GET /crafts/:id
  show : (req, res) ->
    Craft.findOne {_id: req.param('craft_id')}, (err,craft) ->
      res.render 'crafts/show', {title:"Craft: "+craft.title, "craft":craft}

  # GET /crafts/new
  new_form : (req, res) ->
    craft = new Craft
    res.render 'crafts/new', {title: "create a new craft", "craft":"foo"}

  # POST /crafts
  create : (req, res) ->
    craft = new Craft
    craft.title = req.param('title')
    craft.description = req.param('description')
    craft.craft_type  = req.param('description')
    craft.url = req.param('url')
    craft.save ->
      res.redirect '/crafts?wootsuccess'


