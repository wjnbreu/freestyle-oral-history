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


    resize: ->
        self = this
        console.log 'sizing'
        self.renderer.view.style.width = window.innerWidth + 'px'
        self.renderer.view.style.height = window.innerHeight + 'px'



module.exports = Stage

    