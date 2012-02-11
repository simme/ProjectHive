mongoose = module.parent.exports.mongoose
Craft = new mongoose.Schema
  title:
    type: String
  url:
    type: String
  description:
    type: String

mongoose.model 'Craft', Craft
exports.base = mongoose.model 'Craft'
