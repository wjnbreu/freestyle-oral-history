#REQUIRES
async = require 'async'
PIXI = require 'pixi.js'
Doll = require './dolls'
Stage = require './stage'
Animate = require './animate'
Video = require './video'
Nav = require './nav'
Background = require './background'
Info = require './info'
Mobile = require './mobile'
$ = require 'jquery'


#Data containers
stage = {}


#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->

        isMobile = Mobile.init()

        #Add headroom
        Nav()

        if isMobile
            document.body.classList.add 'mobile'
            return

        else

            stage = Stage.init()

            #Bind all videos so we have custom player
            Video.init()

            #Set up background

            

            #Make sure user can exit overlay
            info = document.getElementById 'info'
            info.addEventListener 'click', (ev) ->
                ev.stopPropagation()
                Info.off()

        
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
                    loading = document.getElementById('loading')
                    loading.classList.add 'loaded'
                    setTimeout(Animate.animate, 100)

