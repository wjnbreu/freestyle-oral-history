$ = require 'jquery'
Velocity = require 'velocity-animate'
PIXI = require 'pixi.js'



objects = []
imagesLoaded = 0
speed = 1
dollData = []
info = document.getElementById 'info'
loopCycle = null
audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'

winWidth = window.innerWidth
winHeight = window.innerHeight

parent = document.getElementById 'header'

renderer = PIXI.autoDetectRenderer(winWidth, winHeight, {transparent: true})
parent.appendChild renderer.view
stage = new PIXI.Container()

maxUp = 10












animate = ->

    for image in objects
        #moving right
        if image.direction == 0
            
            #swap directions at borders
            if image.x > window.innerWidth - 200
                image.direction = 1
            
            else
                image.x += image.speed
                image.sprite.position.x += image.speed

                if image.goingUp
                    
                    if image.upCount < maxUp
                        image.sprite.position.y -= 0.5
                        image.upCount += 1
                    else
                        image.goingUp = false

                else
                    if image.upCount > 0
                        image.upCount -= 1
                        image.sprite.position.y += 0.5
                    else
                        image.goingUp = true

        
        #moving left
        else
            if image.x < 0
                image.direction = 0
            else
                image.x -= image.speed
                image.sprite.position.x -= image.speed

                if image.goingUp
                    
                    if image.upCount < maxUp
                        image.sprite.position.y -= 1
                        image.upCount += 1
                    else
                        image.goingUp = false

                else
                    if image.upCount > 0
                        image.upCount -= 0.5
                        image.sprite.position.y += 0.5
                    else
                        image.goingUp = true
                


    requestAnimationFrame(animate)
    renderer.render(stage)








#Constructor
Doll = (item) ->
    self = this

    self.xPos = Math.floor(Math.random() * window.innerWidth) / 3
    self.yPos = (window.innerHeight - 300)
    self.direction = Math.round(Math.random())
    self.path = item.image
    self.bio = item.bio
    self.audio = item.audio
    self.name = item.name
    self.dolls = []
    self.width = window.innerWidth
    self.height = window.innerHeight
    self.imagesLoaded = 0
    self.init()

#Prototype
Doll.prototype=
    
    init: ->
        self = this
        self.loadImage(self.path)


    loadImage: (imagePath) ->
        self = this

        image = new Image()

        image.onload = ->
            
            if self.direction == 0
                imageObject =
                    x: -self.xPos
                    y: self.yPos
                    width: image.width
                    height: image.height
                    img: image
                    sprite: PIXI.Sprite.fromImage(imagePath)
                    speed: Math.random()
                    direction: self.direction
                    upCount: 0
                    goingUp: true
            else
                imageObject =
                    x: self.xPos + self.width
                    y: self.yPos
                    width: image.width
                    height: image.height
                    img: image
                    sprite: PIXI.Sprite.fromImage(imagePath)
                    speed: Math.random()
                    direction: self.direction
                    upCount: 0
                    goingUp: false

            #scale image
            newWidth = (imageObject.width * 400) / imageObject.height


            #------------------------
            # Add to PIXI
            #------------------------
            imageObject.sprite.interactive = true
            imageObject.sprite.width = newWidth
            imageObject.sprite.height = 400
            imageObject.sprite.position.set(imageObject.x, imageObject.y)
            imageObject.sprite.on 'mousedown', ->
                self.info()

            objects.push(imageObject)

            

            stage.addChild(imageObject.sprite)


            imagesLoaded++
            
            self.checkStart()


        
        # Set initial source
        image.src = imagePath

    


    onDown: ->
        console.log 'hit'



    info: ->
        self = this

        name = self.name
        bio = self.bio
        template = "<h2>#{name}</h2><p>#{bio}</p>"
        info.classList.add 'active'
        info.innerHTML = template
        mp3.setAttribute 'src', ''
        mp3.setAttribute 'src', self.audio
        audio.load()
        audio.play()



    clearInfo: ->
        self = this
        info.classList.remove 'active'
        info.innerHTML = ''
        audio.pause()




    checkStart: ->
        self = this
        if imagesLoaded == dollData.length
            animate()






#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->
        for item in data
            dollData = data
            new Doll(item)


