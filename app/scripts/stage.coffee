'use strict'

PIXI = require 'pixi.js'
Animate = require './animate'
ClickArea = require './clickarea'


Stage =

    renderer: {},
    stage: {},

    init: ->
        self = this
        parent = document.getElementById 'header'
        winWidth = window.innerWidth
        winHeight = window.innerHeight

        #PIXI Setup
        self.renderer = PIXI.autoDetectRenderer(winWidth, winHeight, {transparent: true})
        parent.appendChild self.renderer.view
        self.stage = new PIXI.Container()

        #pass stage to animate
        Animate.setStage(self.stage)
        Animate.setRenderer(self.renderer)

        #Set up graphics click area
        clickBox = ClickArea()
        self.stage.addChild(clickBox)

        return self.stage

    addChild: (child) ->
        self = this
        self.stage.addChild(child)


module.exports = Stage

    