### ###############################################################################################
#
#   Watch file changes
#   Using grunt newer to run tasks with changed files only
#
### ###############################################################################################
module.exports = (grunt, options) ->

    copy =
        if options.config.plugin
        then ['copy:plugin_dev']
        else ['copy:build_dev']

    compile =
        if options.config.plugin
        then [
            'newer:coffee:compile'
            'newer:copy:js_compiled'
            'requiregen'
            'karma:unit:run'
        ]
        else [
            'newer:coffee:compile'
            'requiregen'
            'karma:unit:run'
        ]

    configFiles:
        files: [
            'Gruntfile.coffee'
            'grunt/config.coffee'
            'grunt/tasks/*.coffee'
        ]
        options:
            reload: true

    coffee:
        files: '<%= files.coffee %>'
        tasks: compile.concat(copy)

    coffee_unit:
        files: '<%= files.coffee_unit %>'
        tasks: ['newer:coffee:unit'].concat(compile).concat(copy)

    jade:
        files: [
            '<%= files.templates %>'
            '<%= files.index %>'
        ]
        tasks: [
            'newer:jade:dev'
        ].concat(copy)

    less:
        files: '<%= files.less %>'
        tasks: [
            'newer:less:dev'
        ].concat(copy)

    options:
        livereload: true