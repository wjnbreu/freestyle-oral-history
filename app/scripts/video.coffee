'use strict'

$ = require 'jquery'

Video =

    videos: {}
    parents: {}
    
    init: ->
        self = this
        self.videos = $('.video-player')

        self.parents = $('.video-frame')

        #add hidden classes to all videos
        self.videos.each ->
            $(this).addClass 'hidden'


        self.parents.each ->
            item = $(this)
           
            item.on 'click', (e) ->
                item.find('.video-frame__poster').hide()
                player = item.find('.video-player')
                player.removeClass 'hidden'

                src = player.find('iframe').attr 'src'

                src = src + 'autoplay=1'

                player.find('iframe').attr 'src', src


        return


module.exports = Video