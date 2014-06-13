module.exports = (grunt, dir) ->
    dir ?= "grunt"

    # Load Node.js path module
    path = require('path')
    fs = require('fs')

    # Load in the build config files
    defaultConfig = require("./defaultconfig.coffee")
    buildConfig = require(path.join(process.cwd(), dir, "config.coffee"))

    # Load in the build config file
    customtasks = path.join(process.cwd(), dir, "customtasks.coffee")
    if fs.existsSync(customtasks)
        extras = require(customtasks)(grunt)
    else
        extras = {}
    # for now, only one task type is required
    # feel free to add more, and send PR
    extras.extra_code_for_tests_tasks ?= []
    extras.extra_copy ?= []

    # Load grunt tasks and configuration automatically
    options =
        configPath: path.join(__dirname, 'taskconfigs')
        data:
            config: buildConfig
        loadGruntTasks:
            pattern: 'grunt-*'
            config: require('./package.json')
            scope: 'peerDependencies'

    taskConfig = require('load-grunt-config')(grunt, options)

    # Merge the configs
    grunt.config.merge(defaultConfig)
    grunt.log.write(JSON.stringify(grunt.config("files.library.js"))+"\n")
    grunt.config.merge(buildConfig)
    grunt.log.write(JSON.stringify(grunt.config("files.library.js"))+"\n")
    grunt.config.merge(taskConfig)
    grunt.log.write(JSON.stringify(grunt.config("files.library.js"))+"\n")

    ### ###########################################################################################
    #   Alias tasks
    ### ###########################################################################################

    # Compiles all files, then set up a watcher to build whenever files change
    grunt.registerTask 'dev', [
        'default'
        'karma:unit'
        'watch'
    ]
    # Building for the production environment
    grunt.registerTask 'prod', [
        'clean'
        'concurrent:compile_prod'
        'concurrent:copy_prod'
        'concat:bower_config'
        'ngtemplates'
        'requiregen'
        'requirejs'
        'copy:build_prod'
    ].concat extras.extra_copy

    # Steps needed for CI
    grunt.registerTask 'ci', [
        'default'
        'karma:ci'
    ]

    if buildConfig.plugin?
        copy_dev = ['copy:js_compiled', 'requiregen', 'copy:plugin_dev']
    else
        copy_dev = ['requiregen', 'copy:build_dev']

    # Default task
    grunt.registerTask 'default', [
        'clean'
        'concurrent:compile_dev'
        'concurrent:copy_dev'
        'concat:bower_config'
    ].concat extras.extra_code_for_tests_tasks
    .concat copy_dev
    .concat extras.extra_copy

