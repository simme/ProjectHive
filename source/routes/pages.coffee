
exports.home = (req, res)->
  res.render('index', { title: 'Hello world' })

exports.about = (req, res) ->
  res.render('about', { title: 'About project hive' })
