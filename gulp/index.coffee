'use strict'

fs = require 'fs'
tasks = fs.readdirSync './gulp/tasks'


###------------------------
Load each task from task folder
------------------------###
for task in tasks
    require './tasks/' + task
