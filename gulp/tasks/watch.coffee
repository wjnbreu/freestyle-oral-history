'use strict'

config = require '../config'
gulp = require 'gulp'

gulp.task 'watch', ['browserSync', 'serve'], ->

    console.log 'setting up watchers'

    gulp.watch('app/**/*.coffee', ['browserify'])
    gulp.watch(config.styles.src, ['styles'])
    gulp.watch(config.images.src, ['images'])
    # gulp.watch(config.fonts.src, ['fonts'])
    gulp.watch('app/**/*.jade', ['views'])
    gulp.watch('app/**/*.html', ['extras'])