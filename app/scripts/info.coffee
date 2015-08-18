'use strict'

info = document.getElementById 'info'
audio = document.getElementById 'audio'
audiomp3 = document.getElementById 'mp3'



Info =
    
    on: (item) ->
        name = item.name
        bio = item.bio
        template = "<h2>#{name}</h2><p>#{bio}</p>"
        info.classList.add 'active'
        info.innerHTML = template
        mp3.setAttribute 'src', ''
        mp3.setAttribute 'src', item.audio
        audio.load()
        audio.play()

    off: ->
        info.classList.remove 'active'
        info.innerHTML = ''
        audio.pause()


module.exports = Info

