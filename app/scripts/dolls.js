'use strict';

var PIXI = require('pixi.js');
var Stage = require('./stage');
var Info = require('./info');



// ------------------------------------------------
// Constructor
//

var Doll = function(item, image){

    var self = this;

    self.xPos = Math.floor(Math.random() * window.innerWidth) / 3;
    self.yPos = Math.floor(window.innerHeight / 2);
    self.direction = Math.round(Math.random());
    self.path = item.image;
    self.bio = item.bio;
    self.audio = item.audio;
    self.name = item.name;
    self.x = 0;
    self.y = 0;
    self.width = window.innerWidth;
    self.height = Math.floor(window.innerHeight / 2);
    self.img = image;
    self.sprite = PIXI.Sprite.fromImage(item.image);
    self.speed = 0;
    self.upCount = 0;
    self.goingUp = false;
    self.maxUp = Math.floor((Math.random() * 15) + 5);

    self.init();


};



// ------------------------------------------------
// Proto
//

Doll.prototype = {

    init: function(){
        
        var self = this;

        self.speed = Math.random();

        //make sure they are not going TOO slow
        if (self.speed < 0.3){
            self.speed = 0.5;
        }

        self.loadImage();

        window.addEventListener('resize', function(){
            self.resetY();
        }, false);

    },

    resetY: function(){
        var self = this;

        self.yPos = Math.floor(window.innerHeight / 2);
        self.y = self.yPos;
        self.sprite.position.set(self.x, self.y);
    },


    loadImage: function(){
        var self = this;

        if (self.direction === 0){

            self.x = -self.xPos;
            self.y = self.yPos;

            //keep aspect
            self.width = (self.img.width * self.height) / self.img.height;
            self.goingUp = true;

        }

        else{
            self.width = (self.img.width * self.height) / self.img.height;
            self.x = self.xPos + self.width;
            self.y = self.yPos;
            self.goingUp = false;
        }


        // ------------------------------------------------
        // Add to PIXI
        //

        self.sprite.interactive = true;
        self.sprite.buttonMode = true;
        self.sprite.defaultCursor = 'pointer';
        self.sprite.width = self.width;
        self.sprite.height = self.height;
        self.sprite.position.set(self.x, self.y);
        self.sprite.tint = '0xd0d0d0';


        self.sprite.on('mousedown', function(ev){
            ev.stopPropagation();
            Info.on(self);
        });


        self.sprite.on('mouseover', function(){
            self.sprite.tint = '0xFFFFFF';
        });


        self.sprite.on('mouseout', function(){
            self.sprite.tint = '0xd0d0d0';
        });


        Stage.addChild(self.sprite);

        
    }

};


module.exports = Doll;


