'use strict'

s3 = require 'gulp-s3'
fs = require 'fs'
gulp = require 'gulp'


aws = JSON.parse(fs.readFileSync('./aws.json'))

gulp.task 's3', ->
    gulp.src './build/**'
        .pipe(s3(aws))