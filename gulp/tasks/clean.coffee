'use strict'

config = require '../config'
gulp = require 'gulp'
del = require 'del'

gulp.task 'clean', (cb) ->
    console.log config.dist.root
    del([config.dist.root], cb)