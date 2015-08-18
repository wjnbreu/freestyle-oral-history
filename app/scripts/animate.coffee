'use strict'

Stage = require './stage'
stage = {}
renderer = {}


Animate =

    dolls: []

    addDoll: (doll) ->
        self = this
        self.dolls.push(doll)

    setStage: (stageToSet) ->
        stage = stageToSet

    setRenderer: (renderToSet) ->
        renderer = renderToSet

    animate: ->
        self = this
        

        for doll in Animate.dolls
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
        

        



        renderer.render(stage)


        requestAnimationFrame( ->
            Animate.animate()
            )

        


module.exports = Animate
                


    

