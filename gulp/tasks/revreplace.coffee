'use strict'

gulp = require 'gulp'
revReplace = require 'gulp-rev-replace'


gulp.task 'revreplace', ['rev'], ->

    manifest = gulp.src('./build/rev-manifest.json')

    return gulp.src('./app/index.html')
        .pipe(revReplace({manifest: manifest}))
        .pipe(gulp.dest('build/'))

