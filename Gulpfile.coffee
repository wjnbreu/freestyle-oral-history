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
rev = require 'gulp-rev'
revReplace = require 'gulp-rev-replace'
revNapkin = require 'gulp-rev-napkin'
size = require 'gulp-size'



s3 = require 'gulp-s3'
fs = require 'fs'

chalk = require 'chalk'



#-----------------------------------------
#
# Errors
#
#-----------------------------------------

map_error = (err) ->

    if (err.fileName)

        #regular error
        gutil.log(chalk.red(err.name))

        + ': '
        + chalk.yellow(err.fileName.replace(__dirname + '/src/js/', ''))
        + ': '
        + 'Line '
        + chalk.magenta(err.lineNumber)
        + ' & '
        + 'Column '
        + chalk.magenta(err.columnNumber || err.column)
        + ': '
        + chalk.blue(err.description)
    else
        gutil.log(chalk.red(err.name))
        + ': '
        + chalk.yellow(err.message)

    this.end()


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
# ICONS
#
#-----------------------------------------
gulp.task 'icons', ->
    return gulp.src(config.src + '/icons')
        .pipe(gulp.dest.root)


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

    gulp.src(config.extras, {base: config.src})
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
        .on('error', map_error)
        .pipe(plumber())
        .pipe(source('bundle.js'))
        .pipe(buffer())
        .pipe(sourcemaps.init({loadMaps: true}))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(config.scripts.dest))
        .pipe(size({showFiles: true}))



#-----------------------------------------
#
# JS Prod
#
#-----------------------------------------
gulp.task 'prod-js', ->

    b = browserify({
        entries: config.scripts.main
        debug: false
        }).transform(babelify)

    return b.bundle()
        .on('error', map_error)
        .pipe(plumber())
        .pipe(source('bundle.js'))
        .pipe(buffer())
        .pipe(uglify())
        .pipe(gulp.dest(config.scripts.dest))
        .pipe(size({showFiles: true}))



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
        .pipe(size({showFiles: true}))
        .pipe(browserSync.stream())



gulp.task 'prod-styles', ->

    gulp.src(config.styles.src)
        .pipe(plumber())
        .pipe(sass({
            includePaths: require('node-bourbon').includePaths
            sourceComments: 'none'
            sourceMap: 'sass'
            outputStyle: 'compressed'
            }))


        .pipe(postcss([autoprefixer({browsers: ['last 2 versions']})]))
        .on('error', gutil.log)
        .pipe(gulp.dest(config.styles.dest))
        .pipe(size({showFiles: true}))







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
# S3
#
#-----------------------------------------



aws = JSON.parse(fs.readFileSync('./aws.json'))

gulp.task 's3', ->
    gulp.src './build/**'
        .pipe(s3(aws))




#-----------------------------------------
#
# FILE REV
#
#-----------------------------------------

gulp.task 'rev', ->

    gulp.src(['build/**/*.css', 'build/**/*.js'])
        .pipe(rev())
        .pipe(gulp.dest('build/'))
        .pipe(rev.manifest())
        .pipe(gulp.dest('build/'))
        .pipe(revNapkin())





gulp.task 'rev-replace', ['rev'], ->

    manifest = gulp.src('./build/rev-manifest.json')

    gulp.src('build/index.html')
        .pipe(revReplace({
            manifest: manifest
            }))
        .on('error', gutil.log)
        .pipe(plumber())
        .pipe(gulp.dest(config.dist.root))
#-----------------------------------------
#
# TASKS
#
#-----------------------------------------



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


    

    gulp.watch(config.styles.src, ['styles'])
    gulp.watch(config.scripts.src, ['reload-js'])
    gulp.watch(config.views.src, ['reload-html'])





gulp.task 'prod', ['clean'], ->

    global.isProd = true

    runSequence([
        'html'
        'prod-styles'
        'prod-js',
        'extras',
        'data',
        'fonts',
        'images',
        'audio',
    ], ['rev-replace'], ['browser-sync'])





gulp.task('default', ['dev'])
