'use strict'

config = require '../config'
gulp = require 'gulp'
gulpif = require 'gulp-if'
imagemin = require 'gulp-imagemin'
browserSync = require 'browser-sync'
changed = require 'gulp-changed'

gulp.task 'images', ->

    return gulp.src(config.images.src)
        .pipe(changed(config.images.dest))
        .pipe(gulpif(global.isProd, imagemin()))
        .pipe(gulp.dest(config.images.dest))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            once: true
        })))