'use strict'

$ = require 'jquery'


audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'
exit = $('.exit')
portrait = $('.portrait')
info = $('.infotext')
overlay = $('.character-overlay')





Info =

    ctx: null
    buf: null
    alreadyInit: false
    src: null

    init: ->

        self = this

        try
            self.ctx = new AudioContext()
        catch e
            console.log 'No Web Audio Support, Sorry', e

        self.alreadyInit = true
        
        


    
    on: (item) ->

        self = this

        if self.alreadyInit == false
            self.init()




        name = item.name
        bio = item.bio

        info.find('h2').text name
        info.find('p').text bio

        overlay.addClass 'active'

        # mp3.setAttribute 'src', ''
        # mp3.setAttribute 'src', item.audio


        exit.on 'click', (ev) ->
            ev.stopPropagation()
            self.off()


        req = new XMLHttpRequest()

        req.open 'GET', item.audio, true
        req.responseType = 'arraybuffer'

        req.onload = (response) ->
            console.log req.response
            self.ctx.decodeAudioData(req.response, (buffer) ->

                self.buf = buffer
                self.play()
                )

        req.send()





        image = new Image()

        image.onload = ->
            portrait.append image

        image.src = item.path

        # audio.load()
        # audio.play()


    play: ->
        self = this

        self.src = self.ctx.createBufferSource()
        self.src.buffer = self.buf

        self.src.connect(self.ctx.destination)

        self.src.loop = true

        self.src.start(0)




    off: ->

        self = this
        overlay.removeClass 'active'
        info.find('h2').text('')
        info.find('p').text('')
        portrait.html('')
        self.src.stop()


module.exports = Info

