#REQUIRES
$ = require 'jquery'
async = require 'async'
PIXI = require 'pixi.js'
Doll = require './dolls'
Stage = require './stage'
Animate = require './animate'


#Data containers
stage = {}


#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->

        stage = Stage.init()

        

        async.each data, ((item, callback) ->

            image = new Image()

            image.onload = ->

                newDoll = new Doll(item, image)
                Animate.dolls.push(newDoll)
                
                callback()

                return

            image.src = item.image


        ), (err) ->
            if err
                console.log 'Image failed to process'
            else
                setTimeout(Animate.animate, 100)

