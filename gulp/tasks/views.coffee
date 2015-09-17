'use strict'

config = require '../config'
jade = require 'gulp-jade'
gulp = require 'gulp'
browserSync = require 'browser-sync'
gulpif = require 'gulp-if'
gzip = require 'gulp-gzip'


gulp.task 'views', ->
    console.log config.views.src

    gulp.src('app/**/*.html')
        .pipe(gulpif(global.isProd, gzip()))
        .pipe(gulp.dest('build'))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            })))

