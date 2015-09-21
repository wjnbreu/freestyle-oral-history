'use strict';


var MobileDetect = require('mobile-detect');

var Mobile = {
    isMobile: false,

    init: function(){
        var self = this;

        var md = new MobileDetect(window.navigator.userAgent);

        if (md.mobile() !== null){
            self.isMobile = true;
        }

        return self.isMobile;
    }
};


module.exports = Mobile;