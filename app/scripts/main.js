'use strict';

var async = require('async');
var Doll = require('./dolls');
var Stage = require('./stage');
var Animate = require('./animate');
var Video = require('./video');
var Nav = require('./nav');
var Info = require('./info');
var Mobile = require('./mobile');
var Share = require('./share');

var $ = require('jquery');


var Piece = function(){

    var self = this;

    self.isMobile = false;
    self.info = null;
    self.stage = {};
    self.width = window.innerWidth;
    self.height = window.innerHeight;
    self.graphics = document.getElementById('graphics');
    self.init();
};

Piece.prototype = {

    init: function(){
        var self = this;

        //Load up data
        $.ajax({
            url: 'data/data.json',
            success: function(data){

                self.isMobile = Mobile.init();

                function setSize(){
                    self.graphics.style.width = self.width + 'px';
                    self.graphics.style.height = self.height + 'px';
                }


                window.addEventListener('resize', function(){
                    
                    self.width = window.innerWidth;
                    self.height = window.innerHeight;
                    setSize();

                }, false);

                setSize();

                // ------------------------------------------------
                // Add headroom
                //

                new Nav();

                if (self.isMobile){
                    document.body.classList.add('mobile');
                    var loading = document.getElementById('loading');
                    loading.classList.add('loaded');
                }

                if (!self.isMobile){
                    self.stage = Stage.init();

                    //Make sure user can always exit overlay
                    self.info = document.getElementById('info');
                    
                    self.info.addEventListener('click', function(ev){
                        ev.stopPropagation();
                        Info.off();

                    }, false);


                    async.each(data, function(item, callback){

                        var image = new Image();

                        image.onload = function(){
                            var newDoll = new Doll(item, image);

                            Animate.dolls.push(newDoll);

                            callback();
                        };

                        image.src = item.image;

                    }, function(err){

                        if (err){
                            console.log('An image failed to process');
                        }

                        var loading = document.getElementById('loading');
                        loading.classList.add('loaded');
                        
                        setTimeout(Animate.animate, 100);


                    });

                } //end not mobile IF

                // ------------------------------------------------
                // Bind all videos to mimic RBMA Daily player
                //
                Video.init();


                //Setup sharing
                $('.share-icon').each(function(){
                    $(this).click(function(ev){
                        ev.preventDefault();

                        var site = $(this).data('site');
                        new Share(site);
                    });
                });
                
            
            }
        });
    }

};


new Piece();


