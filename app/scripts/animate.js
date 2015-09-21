'use strict';

var stage = {};
var renderer = {};


var Animate = {

    dolls: [],

    addDoll: function(doll){

        var self = this;

        self.dolls.push(doll);

    },

    setStage: function(stageToSet){

        stage = stageToSet;

    },

    setRenderer: function(renderToSet){

        renderer = renderToSet;

    },

    animate: function(){

        var self = this;

        for (var doll of Animate.dolls){

            //moving right
            if (doll.direction === 0) {

                //swap directions at border
                if (doll.x > window.innerWidth - 200){
                    doll.direction = 1;
                }

                else{

                    doll.x += doll.speed;
                    doll.sprite.position.x += doll.speed;

                }

            }
            
            //moving left
            else{

                if (doll.x < 0){
                    doll.direction = 0;
                }

                else{
                    doll.x -= doll.speed;
                    doll.sprite.position.x -= doll.speed;
                }

            }
        }

        renderer.render(stage);

        requestAnimationFrame(function(){
            Animate.animate();
        });
    }

};


module.exports = Animate;



    

