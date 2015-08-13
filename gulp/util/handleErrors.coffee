'use strict'

notify = require 'gulp-notify'

module.exports = (error) ->

    if !global.isProd

        args = Array.prototype.slice.call(arguments)

        notify.onError
            title: 'Compile error'
            message: '<%= error.message %>'
        .apply(this, args)

        this.emit 'end'
    else
        console.log error
        process.exit 1