'use strict'

Background = ->
    self = this
    
    self.canvas = null
    self.ctx = null
    self.mouseX = 0
    self.mouseY = 0
    self.width = window.innerWidth
    self.height = window.innerHeight
    self.hasScrolled = false
    self.container = null

    self.init()



Background.prototype =
    
    init: ->

        self = this

        self.container = document.getElementById 'body'


        self.canvas = document.createElement 'canvas'
        self.ctx = self.canvas.getContext '2d'

        self.canvas.width = window.innerWidth
        self.canvas.height = window.innerHeight
        self.canvas.style.top = '0px'
        self.canvas.style.left = '0px'
        self.canvas.style.position = 'absolute'
        self.canvas.setAttribute 'id', 'background'

        self.container.appendChild self.canvas

        document.addEventListener 'mousemove', (ev) ->
            self.mouseX = ev.clientX
            self.mouseY = ev.clientY

        self.render()


    render: ->

        self = this

        self.ctx.clearRect(0, 0, self.canvas.width, self.canvas.height)

        self.ctx.fillStyle = 'pink'

        for num in [0...20]
            baseBandWidth = self.canvas.width / 39

            offset = 5 * baseBandWidth * num

            bandWidth = baseBandWidth * (Math.abs(offset - self.mouseX) / self.width)

            self.ctx.fillRect(offset, 0, bandWidth, self.height)

        for num in [0...20]
            baseBandWidth = self.canvas.height / 39
            offset = 5 * baseBandWidth * num
            bandWidth = baseBandWidth * (Math.abs(offset - self.mouseY) / self.height)
            self.ctx.fillRect(0, offset, self.width, bandWidth)


        requestAnimationFrame( ->
            self.render()
        )




        

        






module.exports = Background