'use strict'

config = require '../config'
jade = require 'gulp-jade'
gulp = require 'gulp'
browserSync = require 'browser-sync'
gulpif = require 'gulp-if'


gulp.task 'views', ->
    console.log config.views.src

    gulp.src('app/**/*.jade')
        .pipe(jade())
        .pipe(gulp.dest('build'))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            })))

