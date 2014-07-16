module.exports =  (gulp) ->
  ngClassify = require 'gulp-ng-classify'
  sourcemaps = require 'gulp-sourcemaps'
  coffee = require 'gulp-coffee'
  gutil = require 'gulp-util'
  annotate = require 'gulp-ng-annotate'
  concat = require 'gulp-concat'
  cached = require('gulp-cached')
  remember = require('gulp-remember')
  scriptsGlob = 'src/**/*.coffee'

  gulp.task 'scripts', ->
      gulp.src scriptsGlob
        .pipe cached('scripts')
        .pipe sourcemaps.init()
        .pipe ngClassify()
        .pipe coffee()
        .pipe annotate()
        .pipe remember('scripts')
        .pipe concat("main.js")
        .pipe sourcemaps.write(".")
        .pipe gulp.dest 'dist'

  gulp.task "watch", ->
    watcher = gulp.watch(scriptsGlob, ["scripts"]) # watch the same files in our scripts task
    watcher.on "change", (event) ->
      if event.type is "deleted" # if a file is deleted, forget about it
        delete cached.caches.scripts[event.path] # gulp-cached remove api

        remember.forget "scripts", event.path # gulp-remember remove api
