'use strict';

var Headroom = require('headroom.js');


var Nav = function(){
    var self = this;
    self.init();
};


Nav.prototype = {

    init: function(){

        var header = document.getElementById('nav');
        var headroom = new Headroom(header);

        headroom.init();
    }

};



module.exports = Nav;