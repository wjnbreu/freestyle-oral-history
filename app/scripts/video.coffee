'use strict'

$ = require 'jquery'

Video =

    videos: {}
    parents: {}
    
    init: ->
        self = this

        self.parents = $('.video-frame')

        #add hidden classes to all videos
        self.parents.each (index) ->
            $(this).attr 'id', 'video' + index
            $(this).find('iframe').addClass 'hidden'


        self.parents.each ->
            item = $(this)
           
            item.on 'click', (e) ->
                item.find('.video-frame__poster').hide()
                
                player = item.find('iframe')
                
                player.removeClass 'hidden'

                src = player.data 'src'

                src = src + 'autoplay=1'

                player.attr 'src', src


        return


module.exports = Video