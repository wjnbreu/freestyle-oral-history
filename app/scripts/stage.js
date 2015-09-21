'use strict';


var PIXI = require('pixi.js');
var Animate = require('./animate');
var ClickArea = require('./clickarea');


var Stage = {

    renderer: {},
    stage: {},

    init: function(){
        var self = this;

        var parent = document.getElementById('graphics');
        var winWidth = window.innerWidth;
        var winHeight = window.innerHeight;

        //PIXI setup
        self.renderer = new PIXI.CanvasRenderer(winWidth, winHeight, {transparent: true});

        parent.appendChild(self.renderer.view);
        self.stage = new PIXI.Container();

        //pass stage to animate
        Animate.setStage(self.stage);
        Animate.setRenderer(self.renderer);

        //setup graphics click area
        var clickBox = new ClickArea();
        self.stage.addChild(clickBox);

        //listenfor resize
        window.addEventListener('resize', function(){
            self.resize();
        }, false);

        return self.stage;

    },


    addChild: function(child){

        var self = this;

        self.stage.addChild(child);
        return null;
    },

    removeChild: function(child){
        var self = this;

        self.stage.removeChild(child);
        return null;
    },

    removeAll: function(){
        var self = this;

        for (var child in self.stage.children){
            self.stage.removeChild(child);
        }
    },

    resize: function(){
        var self = this;

        var winWidth = window.innerWidth;
        var winHeight = window.innerHeight;

        self.renderer.resize(winWidth, winHeight, {transparent: true});

        Animate.setStage(self.stage);
        Animate.setRenderer(self.renderer);
    }

};



module.exports = Stage;

