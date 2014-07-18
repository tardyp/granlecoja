module.exports =  (gulp) ->
    # gulp is not cs friendly. you need to register coffeescript first to be able to load cs files

    require("coffee-script/register")
    # utilities
    path = require('path')
    fs = require('fs')
    _ = require('lodash')

    # gulp plugins
    ngClassify = require 'gulp-ng-classify'
    sourcemaps = require 'gulp-sourcemaps'
    coffee = require 'gulp-coffee'
    gutil = require 'gulp-util'
    annotate = require 'gulp-ng-annotate'
    concat = require 'gulp-concat'
    cached = require 'gulp-cached'
    remember = require 'gulp-remember'
    merge = require 'merge-stream'
    debug = require 'gulp-debug'
    gutil = require 'gulp-util'

    # Load in the build config files
    config = require("./defaultconfig.coffee")
    buildConfig = require(path.join(process.cwd(), "guanlecoja", "config.coffee"))
    _.merge(config, buildConfig)

    gulp.task 'scripts', ->
        libs = gulp.src(config.files.library.js)
            .pipe cached('libs')
            .pipe sourcemaps.init()
            .pipe concat("libs.js")
           .pipe remember('libs')

        coffee = gulp.src config.files.coffee
            .pipe cached('coffeescripts')
            .pipe sourcemaps.init()
            .pipe ngClassify()
            .pipe coffee().on('error', gutil.log)
            .pipe annotate()
            .pipe remember('coffeescripts')
            .pipe debug({verbose:false})
            .pipe concat("coffee.js")

        merge(libs, coffee)
            .pipe concat("main.js")
            .pipe sourcemaps.write(".")
            .pipe gulp.dest 'dist'

    gulp.task 'scripts2', ->
        coffee = gulp.src config.files.coffee
            .pipe gulp.dest 'dist'
        merge(coffee)
    gulp.task "watch", ->
        gulp.watch(config.files.coffee, ["scripts2"])
    gulp.task "default", ['scripts2', 'watch']
