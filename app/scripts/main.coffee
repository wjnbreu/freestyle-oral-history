#REQUIRES
$ = require 'jquery'
async = require 'async'
PIXI = require 'pixi.js'
Doll = require './dolls'
Stage = require './stage'
ClickArea = require './clickarea'




stage = {}


dolls = []
objects = []





#Add hit area













animate = ->
    for doll in dolls

        #moving right
        if doll.direction == 0
            
            #swap directions at borders
            if doll.x > window.innerWidth - 200
                doll.direction = 1
            
            else
                doll.x += doll.speed
                doll.sprite.position.x += doll.speed

                if doll.goingUp
                    
                    if doll.upCount < doll.maxUp
                        doll.sprite.position.y -= 0.5
                        doll.upCount += 1
                    else
                        doll.goingUp = false

                else
                    if doll.upCount > 0
                        doll.upCount -= 1
                        doll.sprite.position.y += 0.5
                    else
                        doll.goingUp = true

        
        #moving left
        else
            if doll.x < 0
                doll.direction = 0
            else
                doll.x -= doll.speed
                doll.sprite.position.x -= doll.speed

                if doll.goingUp
                    
                    if doll.upCount < doll.maxUp
                        doll.sprite.position.y -= 1
                        doll.upCount += 1
                    else
                        doll.goingUp = false

                else
                    if doll.upCount > 0
                        doll.upCount -= 0.5
                        doll.sprite.position.y += 0.5
                    else
                        doll.goingUp = true
                


    requestAnimationFrame(animate)
    Stage.renderer.render(stage)



#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->

        stage = Stage.init()

        #Set up graphics click area
        clickBox = ClickArea()
        Stage.addChild(clickBox)

        async.each data, ((item, callback) ->

            image = new Image()

            image.onload = ->

                newDoll = new Doll(item, image)
                dolls.push(newDoll)
                callback()
                return

            image.src = item.image


        ), (err) ->
            if err
                console.log 'Image failed to process'
            else
                console.log 'All images loaded'
                setTimeout(animate, 1000)

