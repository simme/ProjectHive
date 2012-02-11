mongoose = module.parent.exports.mongoose
Craft = new mongoose.Schema
  craft_type:
    type: String
  title:
    type: String
  url:
    type: String
  description:
    type: String
  owned_by:
    # user:<user_id> || craft:<craft_id> .. stupid idea?
    type: String     

mongoose.model 'Craft', Craft
exports.base = mongoose.model 'Craft'
