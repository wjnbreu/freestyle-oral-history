'use strict'

PIXI = require 'pixi.js'
Animate = require './animate'
ClickArea = require './clickarea'


Stage =

    renderer: {},
    stage: {},

    init: ->
        self = this
        parent = document.getElementById 'graphics'
        winWidth = window.innerWidth
        winHeight = window.innerHeight

        PIXI.scaleModes.DEFAULT = PIXI.scaleModes.NEAREST;

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

        #listen for resize
        window.addEventListener('resize', ->
            self.resize()
        ,false)

        return self.stage

    addChild: (child) ->
        self = this
        self.stage.addChild(child)
        return null

    removeChild: (child) ->
        self = this
        self.stage.removeChild(child)
        return null


    removeAll: ->
        self = this
        for child in self.stage.children
            self.stage.removeChild(child)
        console.log self.stage
        # for child in Stage.children
        #     console.log child


    resize: ->
        self = this
        winWidth = window.innerWidth
        winHeight = window.innerHeight
        
        self.renderer.resize(winWidth, winHeight, {transparent: true})
        #pass stage to animate
        Animate.setStage(self.stage)
        Animate.setRenderer(self.renderer)



module.exports = Stage

    