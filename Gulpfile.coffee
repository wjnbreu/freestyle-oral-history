'use strict'

global.isProd = false

gulp = require 'gulp'
config = require './config'

sourcemaps = require 'gulp-sourcemaps'
gulpif = require 'gulp-if'
browserSync = require 'browser-sync'
del = require 'del'
changed = require 'gulp-changed'
imagemin = require 'gulp-imagemin'
browserify = require 'browserify'
through2 = require 'through2'
babelify = require 'babelify'
sass = require 'gulp-sass'
autoprefixer = require 'autoprefixer-core'
postcss = require 'gulp-postcss'
gutil = require 'gulp-util'
express = require 'express'
http = require 'http'
morgan = require 'morgan'
runSequence = require('run-sequence')
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'



#-----------------------------------------
#
# AUDIO
#
#-----------------------------------------

gulp.task 'audio', ->

    return gulp.src(config.audio.src)
        .pipe(gulp.dest(config.audio.dest))



#-----------------------------------------
#
# CLEAN
#
#-----------------------------------------

gulp.task 'clean', (cb) ->
    del([config.dist.root], cb)





#-----------------------------------------
#
# DATA
#
#-----------------------------------------
gulp.task 'data', ->
    return gulp.src(config.data.src)
        .pipe(gulp.dest(config.data.dest))


#-----------------------------------------
#
# EXTRAS
#
#-----------------------------------------
gulp.task 'extras', ->

    gulp.src(config.extras)
        .pipe(gulp.dest(config.dist.root))



#-----------------------------------------
#
# FONTS
#
#-----------------------------------------

gulp.task 'fonts', ->

    return gulp.src(config.fonts.src)
        .pipe(changed(config.fonts.dest))
        .pipe(gulp.dest(config.fonts.dest))



#-----------------------------------------
#
# IMAGES
#
#-----------------------------------------

gulp.task 'images', ->

    return gulp.src(config.images.src)
        .pipe(changed(config.images.dest))
        .pipe(gulpif(global.isProd, imagemin()))
        .pipe(gulp.dest(config.images.dest))


#-----------------------------------------
#
# JS
#
#-----------------------------------------

gulp.task 'js', ->

    b = browserify({
        entries: config.scripts.main
        debug: true
        }).transform(babelify)

    return b.bundle()
        .pipe(plumber())
        .pipe(source('bundle.js'))
        .pipe(buffer())
        .pipe(sourcemaps.init({loadMaps: true}))
        .pipe(uglify())
        .on('error', gutil.log)
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(config.scripts.dest))



#-----------------------------------------
#
# STYLES
#
#-----------------------------------------
gulp.task 'styles', ->

    gulp.src(config.styles.src)
        .pipe(plumber())
        .pipe(sass({
            includePaths: require('node-bourbon').includePaths
            sourceComments: global.isProd ? 'none' : 'map'
            sourceMap: 'sass'
            outputStyle: global.isProd ? 'compressed' : 'nested'
            }))

        .pipe(postcss([autoprefixer({browsers: ['last 2 versions']})]))
        .on('error', gutil.log)
        .pipe(gulp.dest(config.styles.dest))





#-----------------------------------------
#
# Views
#
#-----------------------------------------
gulp.task 'html', ->

    gulp.src(config.views.src)
        .pipe(gulp.dest(config.views.dest))





#-----------------------------------------
#
# BROWSERY
#
#-----------------------------------------
gulp.task('browser-sync', ->

    browserSync({
        server: {
            baseDir: './build'
        },
        port: 3000
        })
    )

#-----------------------------------------
#
# TASKS
#
#-----------------------------------------


gulp.task('reload-sass', ['styles'], ->
    browserSync.reload();
    )

gulp.task('reload-js', ['js'], ->
    browserSync.reload()
    )

gulp.task('reload-html', ['html'], ->
    browserSync.reload()
)





gulp.task 'dev', ['clean'], ->

    global.isProd = false

    runSequence([
        'html',
        'styles',
        'js',
        'extras',
        'data',
        'fonts',
        'images',
        'audio',
        ], ['browser-sync'])


    

    gulp.watch(config.styles.src, ['reload-sass'])
    gulp.watch(config.scripts.src, ['reload-js'])
    gulp.watch(config.views.src, ['reload-html'])





gulp.task('default', ['dev'])
