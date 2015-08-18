'use strict'

PIXI = require 'pixi.js'


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

        return self.stage

    addChild: (child) ->
        self = this
        self.stage.addChild(child)


module.exports = Stage

    