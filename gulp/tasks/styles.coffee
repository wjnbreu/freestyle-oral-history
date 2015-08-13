'use strict'

config = require '../config'
gulp = require 'gulp'
sass = require 'gulp-sass'
gulpif = require 'gulp-if'
handleErrors = require '../util/handleErrors'
browserSync = require 'browser-sync'
autoprefixer = require 'autoprefixer-core'
postcss = require 'gulp-postcss'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'




gulp.task 'styles', ->

    return gulp.src('app/styles/**/*.scss')
        .pipe(sass({
            includePaths: require('node-bourbon').includePaths
            sourceComments: global.isProd ? 'none' : 'map'
            sourceMap: 'sass'
            outputStyle: global.isProd ? 'compressed' : 'nested'
            }))
        .pipe(postcss([autoprefixer({browsers: ['last 2 versions']})]))
        .on('error', gutil.log)
        .pipe(gulp.dest(config.styles.dest))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            })))