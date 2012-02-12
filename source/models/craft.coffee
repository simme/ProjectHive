mongoose = require 'mongoose'
mongoose.model 'Craft', new mongoose.Schema
  craft_type:
    # different types
    # organisation | player | caster | lurker | team
    # stream | vod | event | show | blog | strat_guide | fan_art | other
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
