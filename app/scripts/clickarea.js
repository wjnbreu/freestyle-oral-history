'use strict';


var PIXI = require('pixi.js');
var Info = require('./info');


module.exports = function(){

    var graphics = new PIXI.Graphics();

    graphics.drawRect(0, 0, window.innerWidth, window.innerHeight);

    graphics.interactive = true;
    graphics.buttonMode = true;

    graphics.hitArea = new PIXI.Rectangle(0, 0, window.innerWidth, window.innerHeight);

    graphics.click = function(){
        Info.off();
    };


    window.addEventListener('resize', function(){

        graphics.clear();
        graphics.interactive = true;
        graphics.buttonMode = true;

        graphics.drawRect(0, 0, window.innerWidth, window.innerHeight);
        graphics.hitArea = new PIXI.Rectangle(0, 0, window.innerWidth, window.innerHeight);

    }, false);

    return graphics;

};

