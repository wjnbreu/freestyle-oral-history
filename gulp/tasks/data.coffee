gulp = require 'gulp'
config = require '../config'


gulp.task 'data', ->

    return gulp.src(config.data.src)
        .pipe(gulp.dest(config.data.dest))