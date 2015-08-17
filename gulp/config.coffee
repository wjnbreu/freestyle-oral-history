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
        'src': 'app/scripts/**/*.coffee'
        'dest': 'build/js'
    }

    'views': {
        'watch': [
            'app/index.jade'
            'app/views/**/*.jade'
        ]
        'src': 'app/views/**/*.jade'
        'dest': 'app/views'
    }

    'fonts': {
        'src': ['app/fonts/**/*']
        'dest': 'build/fonts'
    }

    'images': {
        'src': 'app/images/**/*'
        'dest': 'build/images'
    }

    'dist': {
        'root': 'build'
    }
}