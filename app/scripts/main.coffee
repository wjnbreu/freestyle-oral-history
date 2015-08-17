$ = require 'jquery'
Velocity = require 'velocity-animate'



objects = []
imagesLoaded = 0
speed = 1
dollData = []
info = document.getElementById 'info'
loopCycle = null
audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'




draw = ->
    for image in objects
        #moving right
        if image.direction == 0

            #swap directions at borders
            if image.x > window.innerWidth - 200
                image.direction = 1
            else
                image.x += image.speed

            Velocity(image.img, {
                translateX: image.x + 'px'
                translateY: image.y + 'px'
                },0)

        #LEFT
        else
            if image.x < 0
                image.direction = 0
            else
                image.x -= image.speed
            
            Velocity(image.img, {
                translateX: image.x + 'px'
                translateY: image.y + 'px'
                },0)


    loopCycle = requestAnimationFrame(draw)








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
        image.classList.add 'doll'
        parent = document.getElementById 'header'


        image.onload = ->

            image.setAttribute 'draggable', 'false'

            parent.appendChild(image)

            if self.direction == 0
                imageObject =
                    x: -self.xPos
                    y: self.yPos
                    img: image
                    speed: Math.random()
                    direction: self.direction
            
            else
                imageObject =
                    x: self.xPos + self.width
                    y: self.yPos
                    img: image
                    speed: Math.random()
                    direction: self.direction


            objects.push(imageObject)
            

            image.style.left = imageObject.x
            image.style.top = imageObject.y

            image.addEventListener 'click', (e) ->
                
                e.stopPropagation();

                self.info()

            document.body.addEventListener 'click', ->
                self.clearInfo()



        

            imagesLoaded++

            self.checkStart()


        image.src = imagePath



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
            draw()






#------------------------
# Load Up Data
#------------------------
$.ajax
    url: 'data/data.json'
    success: (data) ->
        for item in data
            dollData = data
            console.log item
            new Doll(item)


