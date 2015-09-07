'use strict'

gulp = require 'gulp'
config = require '../config'

gulp.task 'extras', ->
    gulp.src(['app/.htaccess', 'app/robots.txt', 'app/favicon.ico'])
        .pipe(gulp.dest('build/'))