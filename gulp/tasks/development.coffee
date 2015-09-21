'use strict'

gulp = require 'gulp'
runSequence = require('run-sequence')

gulp.task 'dev', ['clean'], (cb) ->

    global.isProd = false

    runSequence([
        'styles',
        'browserify',
        'revreplace',
        'images',
        'fonts',
        'data',
        'audio',
        'extras',
        'views'
        ], 'watch', cb)
