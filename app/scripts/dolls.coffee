'use strict'

PIXI = require 'pixi.js'
Stage = require './stage'
Info = require './info'



#Constructor
Doll = (item, image) ->
    self = this
    
    self.xPos = Math.floor(Math.random() * window.innerWidth) / 3
    self.yPos = Math.floor(window.innerHeight / 2)
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
    self.speed = 0
    self.upCount = 0
    self.goingUp = false
    self.maxUp = Math.floor((Math.random() * 15) + 5)

    self.init()


#Prototype
Doll.prototype =
    
    init: ->
        self = this

        self.speed = Math.random()

        if self.speed < 0.3
            self.speed = 0.5


        self.loadImage()

        window.addEventListener 'resize', ->
            self.resetY()


    resetY: ->
        self = this


        self.yPos = Math.floor(window.innerHeight / 2)
        self.y = self.yPos
        self.sprite.position.set(self.x, self.y)


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
        self.sprite.defaultCursor = 'pointer'
        self.sprite.width = self.width
        self.sprite.height = self.height
        self.sprite.position.set(self.x, self.y)
        self.sprite.tint = '0xd0d0d0'

        self.sprite.on 'mousedown', (event) ->
            event.stopPropagation()
            Info.on(self)

        self.sprite.on 'mouseover', (event) ->
            self.sprite.tint = '0xFFFFFF'

        self.sprite.on 'mouseout', (event) ->
            self.sprite.tint = '0xd0d0d0'


    

        

        Stage.addChild(self.sprite)

        return

    


    swapImage: ->
        self = this
        self.sprite = PIXI.Sprite.fromImage('images/')


    checkStart: ->
        self = this

            



module.exports = Doll
