mongoose = require 'mongoose'

mongoose.model 'User', new mongoose.Schema
  name:
    type: String
    index: true
    unique: true