'use strict'

info = document.getElementById 'info'
audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'




Info =
    
    on: (item) ->

        self = this

        name = item.name
        bio = item.bio
        template = "<h2>#{name}</h2><p>#{bio}</p>"
        info.classList.add 'active'
        info.innerHTML = template
        mp3.setAttribute 'src', ''
        mp3.setAttribute 'src', item.audio

        exit = document.createElement 'div'

        imageContainer = document.createElement 'div'
        imageContainer.setAttribute 'class', 'portrait'

        
        exit.setAttribute 'class', 'exit'
        exit.setAttribute 'id', 'exit'

        info.appendChild imageContainer
        info.appendChild exit

        exit.addEventListener 'click', (ev) ->
            ev.stopPropagation()
            self.off()

        console.log item



        image = new Image()

        image.onload = ->
            imageContainer.appendChild image

        image.src = item.path

        audio.load()
        audio.play()


    off: ->

        self = this
        info.classList.remove 'active'
        info.innerHTML = ''
        audio.pause()


module.exports = Info

