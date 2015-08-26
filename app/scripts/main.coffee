#REQUIRES
async = require 'async'
PIXI = require 'pixi.js'
Doll = require './dolls'
Stage = require './stage'
Animate = require './animate'
Video = require './video'
Nav = require './nav'


#Data containers
stage = {}


#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->

        stage = Stage.init()

        #Bind all videos
        Video.init()

        #Add headroom
        Nav()

    
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

