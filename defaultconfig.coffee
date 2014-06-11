### ###############################################################################################
#
#   This module contains all default configuration for the build process
#   Variables in this file can be overridden using the grunt/config.coffee file
#   located in the project directory
#
### ###############################################################################################
module.exports =

    ### ###########################################################################################
    #   Directories
    ### ###########################################################################################
    dir:
        # The build folder is where the app resides once it's completely built
        build: 'static'

    ### ###########################################################################################
    #   This is a collection of file patterns
    ### ###########################################################################################
    files:
        # JavaScript
        js: [
            'src/app/**/*.js'
            '!src/app/**/*.spec.js'
        ]

        # JavaScript test
        js_unit: [
            'src/app/**/*.spec.js'
        ]

        # CoffeeScript
        coffee: [
            'src/app/**/*.coffee'
            '!src/app/**/*.spec.coffee'
        ]

        # CoffeeScript test
        coffee_unit: [
            'test/**/*.coffee'
            'src/app/**/*.spec.coffee'
        ]

        # Jade templates
        templates: [
            'src/app/**/*.tpl.jade'
        ]

        # Jade index
        index: [
            'src/app/index.jade'
        ]

        # Less stylesheets
        less: [
            'src/styles/styles.less'
            'src/app/**/*.less'
        ]

        # Images
        images: [
            'src/img/**/*.{png,jpg,gif,ico}'
        ]

        # Fonts
        fonts: [
            'src/libs/font-awesome/fonts/*'
        ]

        # Common files
        common: [
            'src/common/*'
        ]

        # Library files
        library:

            # JavaScript libraries
            js: [
            ]

            # JavaScript libraries used during testing only
            js_unit: [
                'src/libs/angular-mocks/angular-mocks.js'
            ]
