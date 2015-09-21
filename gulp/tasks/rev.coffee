'use strict'

gulp = require 'gulp'
rev = require 'gulp-rev'

gulp.task 'rev', ->

    return gulp.src(['build/**/*.css', 'build/**/*.js'])
        .pipe(rev())
        .pipe(gulp.dest('build/'))
        .pipe(rev.manifest())
        .pipe(gulp.dest('build/'))