'use strict'

config = require '../config'
gulp = require 'gulp'
coffeelint = require 'gulp-coffeelint'

gulp.task 'lint', ->
    return gulp.src([config.scripts.src, '!app/js/templates.js'])
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())