gulp   = require 'gulp'
shell  = require 'gulp-shell'
coffee = require 'gulp-coffee'


gulp.task 'compile:coffee', () ->
    gulp.src 'express_app/**/*.coffee'
        .pipe coffee()
        .pipe gulp.dest('express_app')

gulp.task 'run', ['compile:coffee'], shell.task([
  'forever express_app/bin/www & ruby sinatra_app/main.rb'
])
