#REQUIRES
async = require 'async'
PIXI = require 'pixi.js'
Doll = require './dolls'
Stage = require './stage'
Animate = require './animate'
Video = require './video'
Nav = require './nav'
Background = require './background'
Info = require './info'
Mobile = require './mobile'
Share = require './share'
$ = require 'jquery'


Piece = ->

    self = this
    self.isMobile = false
    self.stage = null
    self.info = null
    self.stage = {}
    self.width = window.innerWidth
    self.height = window.innerHeight
    self.graphics = document.getElementById 'graphics'
    self.init()


Piece.prototype =

    init: ->

        self = this

        #------------------------
        # Load Up Data
        #------------------------
        $.ajax
            url: 'data/data.json'
            success: (data) ->

                self.isMobile = Mobile.init()

                setSize = ->
                    self.graphics.style.width = self.width + 'px'
                    self.graphics.style.height = self.height + 'px'

                window.addEventListener 'resize', ->
                    self.width = window.innerWidth
                    self.height = window.innerHeight
                    setSize()

                setSize()


                #Add headroom
                new Nav()

                if self.isMobile
                    document.body.classList.add 'mobile'
                    loading = document.getElementById('loading')
                    loading.classList.add 'loaded'

                if !self.isMobile
                    self.stage = Stage.init()

                    #Make sure user can exit overlay
                    self.info = document.getElementById 'info'
                    self.info.addEventListener 'click', (ev) ->
                        ev.stopPropagation()
                        Info.off()


                    async.each data, ((item, callback) ->

                        image = new Image()

                        image.onload = ->

                            newDoll = new Doll(item, image)
                            Animate.dolls.push(newDoll)
                            
                            callback()

                            return

                        image.src = item.image


                    ), (err) ->
                        if err
                            console.log 'Image failed to process'
                        else
                            loading = document.getElementById('loading')
                            loading.classList.add 'loaded'
                            setTimeout(Animate.animate, 100)

                    
                #Bind all videos so we have custom player
                Video.init()

                #setup sharing
                $('.share-icon').each ->

                    $(this).click (ev) ->
                        ev.preventDefault()

                        site = $(this).data('site')
                        
                        Share(site)

                

    

            

        return


new Piece()


