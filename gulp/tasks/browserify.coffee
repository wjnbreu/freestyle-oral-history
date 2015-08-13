'use strict'

gulp = require 'gulp'
config = require '../config'
browserify = require 'browserify'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
source = require 'vinyl-source-stream'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
streamify = require 'gulp-streamify'
watchify = require 'gulp-watchify'
uglify = require 'gulp-uglify'
handleErrors = require '../util/handleErrors'
browserSync = require 'browser-sync'
debowerify = require 'debowerify'
ngAnnotate = require 'gulp-ng-annotate'
coffeeify = require 'gulp-coffeeify'
transform = require 'vinyl-transform'
browserSync = require 'browser-sync'





gulp.task 'browserify', ->

    gulp.src('app/scripts/main.coffee')
        .pipe(coffeeify({
            options:
                ignoreMissing: true
                debug: true
            }))
        # .pipe(ngAnnotate())
        # .pipe(uglify())
        .pipe(gulp.dest('./build/js'))
        .pipe(gulpif(browserSync.active, browserSync.reload({
            stream: true
            })))
