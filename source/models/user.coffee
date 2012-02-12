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
  flattr:
    token:
      type: String
    username:
      type: String
  justin:
    token:
      type: String
