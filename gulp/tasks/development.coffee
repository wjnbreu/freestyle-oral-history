'use strict'

gulp = require 'gulp'
runSequence = require('run-sequence')

gulp.task 'dev', ['clean'], (cb) ->

    global.isProd = false

    runSequence([
        'styles',
        'views',
        'images',
        'fonts',
        'data',
        'audio',
        'extras',
        'browserify'
        ], 'watch', cb)
