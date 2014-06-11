module.exports = (grunt, dir) ->
    dir ?= "grunt"

    # Load Node.js path module
    path = require('path')

    # Load in the build config files
    defaultConfig = require("./defaultconfig.coffee")
    buildConfig = require(path.join(process.cwd(), dir, "config.coffee"))

    # Load in the build config file
    extras = require(path.join(process.cwd(), dir, "customtasks.coffee"))(grunt)

    # for now, only one task type is required
    # feel free to add more, and send PR
    extras.extra_code_for_tests_tasks ?= []

    # Load grunt tasks and configuration automatically
    options =
        configPath: path.join(__dirname, 'taskconfigs')
        data:
            config: buildConfig
    taskConfig = require('load-grunt-config')(grunt, options)

    # Merge the configs
    grunt.config.merge(defaultConfig)
    grunt.config.merge(buildConfig)
    grunt.config.merge(taskConfig)

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
    ]

    # Steps needed for CI
    grunt.registerTask 'ci', [
        'default'
        'karma:ci'
    ]

    # Default task
    grunt.registerTask 'default', [
        'clean'
        'concurrent:compile_dev'
        'concurrent:copy_dev'
        'concat:bower_config'
    ].concat extras.extra_code_for_tests_tasks
    .concat [
        'requiregen'
        'copy:build_dev'
    ]
