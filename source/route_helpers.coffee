mongoose = require 'mongoose'
User = mongoose.model 'User'

module.exports =
  isAuthenticated:(req) ->
    if req.session.user_id && req.session.user_id != ""
      console.log "session is authenticated #{req.session.user_id}"
      return true
    console.log "session is not authenticated"
    return false

  ensureAuthenticated:(req, res, next) ->
    if ! module.exports.isAuthenticated(req)
      console.log "session not authenticated; try to crash"
      req.flash "error", "you are not authenticated"
      res.redirect '/?YOU ARE NOT LOGGED IN'
      return
    else
      req.user_id = req.session.user_id
      next()
