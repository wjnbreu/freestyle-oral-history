'use strict'

PIXI = require 'pixi.js'
Info = require './info'




module.exports = ->
    

    graphics = new PIXI.Graphics()
    graphics.drawRect(0, 0, window.innerWidth, window.innerHeight)

    graphics.interactive = true
    graphics.buttonMode = true

    graphics.hitArea = new PIXI.Rectangle(0, 0, window.innerWidth, window.innerHeight)

    graphics.click = (event) ->
        Info.off()


    window.addEventListener 'resize', ->
        graphics.clear()

        graphics.interactive = true
        graphics.buttonMode = true

        graphics.drawRect(0, 0, window.innerWidth, window.innerHeight)
        graphics.hitArea = new PIXI.Rectangle(0, 0, window.innerWidth, window.innerHeight)
        


    return graphics
