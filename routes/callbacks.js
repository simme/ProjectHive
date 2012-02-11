/**
 *
 * GET /index
 */

exports.index = function(req, res){
  res.render('callback', { title: 'Hello CALLBACK' })
};

exports.flattr = function(req, res){
  res.render('callback', { title: 'Hello Flattr callback' })
};

exports.justin = function(req, res){
  res.render('callback', { title: 'Hello Justin callback' })
};
