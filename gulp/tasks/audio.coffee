'use strict'

gulp = require 'gulp'
config = require '../config'


gulp.task 'audio', ->
    return gulp.src(config.audio.src)
        .pipe(gulp.dest(config.audio.dest))