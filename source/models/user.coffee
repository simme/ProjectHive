mongoose = module.parent.exports.mongoose
User = new mongoose.Schema
  name:
    type: String
    index: true
    unique: true

mongoose.model 'User', User
exports = mongoose.model 'User'
