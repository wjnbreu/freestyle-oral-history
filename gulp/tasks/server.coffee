'use strict'

config = require '../config'
http = require 'http'
express = require 'express'
gulp = require 'gulp'
gutil = require 'gulp-util'
morgan = require 'morgan'


gulp.task 'serve', ->

    server = express()

    #log all requests to console
    server.use(morgan('dev'))
    server.use(express.static(config.dist.root))

    #server index.html for all routes to leave routing up to angular
    server.all('/*', (req, res) ->
        res.sendFile('index.html', {root: 'build'})
        )

    #start server
    s = http.createServer(server)

    s.on 'error', (err) ->
        if err.code == 'EADDRINUSE'
            gutil.log "Dev server already started at port #{config.serverPort}"

        else
            throw err

    s.listen(config.serverPort)

