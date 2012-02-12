# GET /
module.exports =
  index: (req, res) ->
    res.render "index",
      title: "welcome"
      trending:
        [{
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'Protoss are the best'
          url: 'http://iamsim.me'
        }
        , {
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'Disgusting zerg is disgusting'
          url: 'http://iamsim.me'
        }
        , {
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'BBShakenbake is really a bronze player'
          url: 'http://iamsim.me'
        }
        , {
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'Animal testing? Try zergling testing'
          url: 'http://iamsim.me'
        }
        , {
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'Zerg. No.'
          url: 'http://iamsim.me'
        }
        , {
          image:
            url: '/images/epicprotoss.jpg'
            alt: 'En broken testbild'
          title: 'Zerg means poop in latin'
          url: 'http://iamsim.me'
        }]