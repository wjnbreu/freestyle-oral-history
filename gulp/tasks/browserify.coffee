'use strict'

gulp = require 'gulp'
config = require '../config'
browserify = require 'browserify'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'
browserSync = require 'browser-sync'
coffeeify = require 'gulp-coffeeify'
browserSync = require 'browser-sync'
gzip = require 'gulp-gzip'





gulp.task 'browserify', ->

    gulp.src('app/scripts/main.coffee')
        .pipe(sourcemaps.init())
        .pipe(coffeeify({
            options:
                ignoreMissing: true
                debug: true
            }))
        .pipe(gulpif(global.isProd, uglify()))
        .pipe(sourcemaps.write())
        .pipe(gulpif(global.isProd, gzip()))
        .pipe(gulp.dest('./build/js'))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            })))
