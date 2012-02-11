mongoose = module.parent.exports.mongoose
User = new mongoose.Schema
  name: String
mongoose.model 'User', User
exports.base = mongoose.model 'User'
