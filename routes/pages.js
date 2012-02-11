
/*
 * GET home page.
 */

exports.home = function(req, res){
  res.render('index', { title: 'Hello world' })
};

exports.about = function(req, res) {
  res.render('about', { title: 'About project hive' })
};
