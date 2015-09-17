'use strict'

Headroom = require 'headroom.js'


Nav = ->
    self = this
    self.init()


Nav.prototype =

    init: ->

        header = document.getElementById 'nav'

        headroom = new Headroom(header)

        headroom.init()



module.exports = Nav