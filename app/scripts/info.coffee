'use strict'

$ = require 'jquery'


audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'
exit = $('.exit')
portrait = $('.portrait')
info = $('.infotext')
overlay = $('.character-overlay')





Info =
    
    on: (item) ->

        self = this



        name = item.name
        bio = item.bio

        info.find('h2').text name
        info.find('p').text bio

        overlay.addClass 'active'

        mp3.setAttribute 'src', ''
        mp3.setAttribute 'src', item.audio


        exit.on 'click', (ev) ->
            ev.stopPropagation()
            self.off()




        image = new Image()

        image.onload = ->
            portrait.append image

        image.src = item.path

        audio.load()
        audio.play()


    off: ->

        self = this
        overlay.removeClass 'active'
        info.find('h2').text('')
        info.find('p').text('')
        portrait.html('')
        audio.pause()


module.exports = Info

