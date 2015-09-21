'use strict';

var $ = require('jquery');

var exit = $('.exit');
var portrait = $('.portrait');
var info = $('.infotext');
var overlay = $('.character-overlay');

var Info = {

    ctx: null,
    buf: null,
    alreadyInit: false,
    src: null,

    init: function(){

        var self = this;

        try{
            self.ctx = new AudioContext();
        }
        catch(err){
            console.log('No Web Audio Support.', err);
        }

        self.alreadyInit = true;

    },

    on: function(item){
        var self = this;

        if (self.alreadyInit === false){
            self.init();
        }

        let name = item.name;
        let bio = item.bio;

        info.find('h2').text(name);
        info.find('p').text(bio);

        overlay.addClass('active');

        exit.on('click', function(ev){
            ev.stopPropagation();
            self.off();
        });

        var req = new XMLHttpRequest();

        req.open('GET', item.audio, true);
        req.responseType = 'arraybuffer';

        req.onload = function(response){

            self.ctx.decodeAudioData(req.response, function(buffer){

                self.buf = buffer;
                self.play();

            });

        };

        req.send();


        var image = new Image();

        image.onload = function(){
            portrait.append(image);
        };

        image.src = item.path;

    },

    play: function(){

        var self = this;

        self.src = self.ctx.createBufferSource();
        self.src.buffer = self.buf;

        self.src.connect(self.ctx.destination);
        self.src.loop = true;
        self.src.start(0);
    },

    off: function(){
        var self = this;

        overlay.removeClass('active');
        info.find('h2').text('');
        info.find('p').text('');
        portrait.html('');
        self.src.stop();
    }

};


module.exports = Info;

