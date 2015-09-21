'use strict'

module.exports = {
    
    'browserPort': 9000
    'UIPort': 9001
    'serverPort': 9002

    'data': {
        'src': 'app/data/data.json'
        'dest': 'build/data'
    }

    'audio': {
        'src': 'app/audio/*',
        'dest': 'build/audio'
    }

    'styles': {
        'src': 'app/styles/**/*.scss'
        'dest': 'build/css'
    }

    'scripts': {
        'src': 'app/scripts/**/*.js'
        'dest': 'build/js'
        'main': 'app/scripts/main.js'
        'base': 'app/scripts/'
    }

    'views': {
        'src': 'app/**/*.html'
        'dest': 'build'
    }

    'fonts': {
        'src': ['app/fonts/**/*']
        'dest': 'build/fonts'
    }

    'images': {
        'src': 'app/images/**/*'
        'dest': 'build/images'
    }

    'src': 'app/'

    'dist': {
        'root': 'build'
    }

    extras: ['app/.htaccess', 'app/robots.txt', 'app/favicon.ico', 'app/icons/*']
}