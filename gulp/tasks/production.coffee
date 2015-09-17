'use strict'

gulp = require 'gulp'
runSequence = require('run-sequence')

gulp.task 'prod', ['clean'], (cb) ->

    global.isProd = true

    runSequence([
        'styles',
        'views',
        'images',
        'fonts',
        'data',
        'audio',
        'browserify',
        'extras'
        ], cb)
