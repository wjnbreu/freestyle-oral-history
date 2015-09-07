'use strict'

Headroom = require 'headroom.js'



module.exports = ->

    console.log 'hit'

    header = document.getElementById 'nav'

    headroom = new Headroom(header)

    headroom.init()
