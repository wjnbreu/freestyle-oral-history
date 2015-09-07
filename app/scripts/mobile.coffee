'use strict'


MobileDetect = require 'mobile-detect'

Mobile =

    isMobile: false

    init: ->
        self = this

        md = new MobileDetect(window.navigator.userAgent)

        if md.mobile() != null
            self.isMobile = true


        return self.isMobile


module.exports = Mobile