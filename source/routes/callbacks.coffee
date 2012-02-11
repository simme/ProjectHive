exports.index = (req, res) ->
  res.render('callback', { title: 'Hello CALLBACK' })

exports.flattr = (req, res) ->
  res.render('callback', { title: 'Hello Flattr callback' })

exports.justin = (req, res) ->
  res.render('callback', { title: 'Hello Justin callback' })
