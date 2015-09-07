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

            
            #moving left
            else
                if doll.x < 0
                    doll.direction = 0
                else
                    doll.x -= doll.speed
                    doll.sprite.position.x -= doll.speed

        



        renderer.render(stage)


        requestAnimationFrame( ->
            Animate.animate()
            )

        


module.exports = Animate
                


    

