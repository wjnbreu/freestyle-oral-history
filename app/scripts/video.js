'use strict';

var $ = require('jquery');


let Video = {

    videos: [],
    parents: null,

    init: function(){

        var self = this;

        self.parents = $('.video-frame');

        //add hidden classes to all videos
        self.parents.each(function(index){
            $(this).attr('id', 'video' + index);
            $(this).find('iframe').addClass('hidden');
        });

        self.parents.each(function(){
            var item = $(this);

            item.on('click', function(){
                item.find('.video-frame__poster').hide();

                var player = item.find('iframe');

                player.removeClass('hidden');
                var src = player.data('src');
                src = src + 'autoplay=1';
                player.attr('src', src);

            });
        });
    }

};



module.exports = Video;