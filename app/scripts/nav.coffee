'use strict'

Headroom = require 'headroom.js'



module.exports = ->


    header = document.getElementById 'nav'

    headroom = new Headroom(header)

    headroom.init()
