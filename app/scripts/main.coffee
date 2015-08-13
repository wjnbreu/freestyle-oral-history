$ = require 'jquery'

images = ['doll1.gif', 'doll2.gif', 'doll3.gif', 'doll4.gif', 'doll5.gif']

imageSrc = 'images/'



#Constructor
Doll = (imagePath) ->
    self = this

    self.xPos = Math.floor(Math.random() * window.innerWidth)
    self.yPos = window.innerHeight - 100
    self.path = imagePath
    self.init()

#Prototype
Doll.prototype=
    
    init: ->
        self = this
        self.loadImage(self.path)


    loadImage: (imagePath) ->

        image = new Image()

        image.onload = ->
            console.log image


        image.src = imagePath



#Call
for image in images
    path = imageSrc + image
    new Doll(path)



