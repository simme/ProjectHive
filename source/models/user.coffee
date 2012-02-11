mongoose = require 'mongoose'

mongoose.model 'User', new mongoose.Schema
  name:
    type: String
    index: true
    unique: true
  email:
    type: String
    index: true
    unique: true
  flattr_token:
    type: String
  justin_token:
    type: String
