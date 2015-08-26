'use strict'

PIXI = require 'pixi.js'
Stage = require './stage'
Loaded = require './loaded'
Info = require './info'



#Constructor
Doll = (item, image) ->
    self = this
    
    self.xPos = Math.floor(Math.random() * window.innerWidth) / 3
    self.yPos = (window.innerHeight - 300)
    self.direction = Math.round(Math.random())
    self.path = item.image
    self.bio = item.bio
    self.audio = item.audio
    self.name = item.name
    self.width = window.innerWidth
    self.height = window.innerHeight
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = Math.floor(window.innerHeight / 2)
    self.img = image
    self.sprite = PIXI.Sprite.fromImage(item.image)
    self.speed = Math.random()
    self.upCount = 0
    self.goingUp = false
    self.maxUp = Math.floor((Math.random() * 15) + 5)

    self.init()


#Prototype
Doll.prototype =
    
    init: ->
        self = this
        self.loadImage()


    loadImage: ->
        
        self = this
 
            
        if self.direction == 0

            self.x = -self.xPos
            self.y = self.yPos
            #Keep aspect
            self.width = (self.img.width * self.height) / self.img.height
            self.goingUp = true
                


        else

            self.width = (self.img.width * self.height) / self.img.height
            self.x = self.xPos + self.width
            self.y = self.yPos
            self.goingUp = false



        #------------------------
        # Add to PIXI
        #------------------------
        self.sprite.interactive = true
        self.sprite.buttonMode = true
        self.sprite.width = self.width
        self.sprite.height = self.height
        self.sprite.position.set(self.x, self.y)
        

        self.sprite.on 'mousedown', (event) ->
            event.stopPropagation()
            Info.on(self)

            # console.log self

        

        Stage.addChild(self.sprite)
        return

    


    


    checkStart: ->
        self = this
            



module.exports = Doll
