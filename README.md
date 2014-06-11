# granlecoja: opinionated RAD build environment for single page web apps

It integrates several web technologies and methodologies together to accelerate web development.

- Grunt: build tool
- Angularjs: MVC framework
- Less: CSS preprocessor
- Coffee-script: Javascript language
- Jade: template engine
- Bootstrap: css framework
- require.js: for lazy loading and plug-in system
- bower: js library

Grunt is a nice and generic tool for creating build system. Its available plug-ins are evolving
fast so each time a new plug-in is changing the game you have to update all your projects
in order to use it.

Granlecoja is made to solve this problem. just make your web app depend on "latest"
version of Granlecoja, and the greatest build tools will automatically be synchronized.

In order to make this promise, Granlecoja needs to make some decision for you.
This is why it defines the languages and framework you use, and the organization of your project.

### yo

Well known tool Yeoman has similar goals, but it does not provide automatic update of the tools.
Only templates and boilerplate generation is done, with no way of upgrading your project.

yo templates using Granlecoja maybe created in the future

### Why the name ``granlecoja``

Because it sounds much better than grunt-angular-less-coffee-jade

### Configuration

Make your package.js depend on "granlecoja" == "latest"

create a Gruntfile.coffee with only two following lines:

    module.exports = (grunt) ->
        require("granlecoja")(grunt, "grunt")

create a "grunt/config.coffee" with the configuration variables:

    ### ###############################################################################################
    #
    #   This module contains all configuration for the build process
    #
    ### ###############################################################################################
    module.exports =

        ### ###########################################################################################
        #   Directories
        ### ###########################################################################################
        dir:
            # The build folder is where the app resides once it's completely built
            build: 'buildbot_www'

        ### ###########################################################################################
        #   This is a collection of file patterns
        ### ###########################################################################################
        files:
            # Library files
            library:

                # JavaScript libraries. Which javascript files to include, from the
                # one downloaded by bower
                js: [
                    'src/libs/jquery/dist/jquery.js'
                    'src/libs/angular/angular.js'
                    'src/libs/requirejs/require.js'

                    'src/libs/angular-animate/angular-animate.js'
                    'src/libs/angular-bootstrap/ui-bootstrap-tpls.js'
                    'src/libs/angular-ui-router/release/angular-ui-router.js'
                    'src/libs/angular-recursion/angular-recursion.js'

                    'src/libs/lodash/dist/lodash.js'
                    'src/libs/moment/moment.js'
                    'src/libs/underscore.string/lib/underscore.string.js'
                    'src/libs/restangular/dist/restangular.js'
                ]

You can override more file patterns. See the defaultconfig.coffee for list of patterns available.
Normally, only the Javascript libraries are needed to configure.

create a ".bowerrc" with the configuration variables:

    {"directory": "src/libs"}

so that your bower dependencies are stored on side of your source code.
You also want to configure ".gitignore", to ignore this directory.

Use bower.json as usual to describe your javascript libraries dependancies. You at least need angular.js > 1.2, bootstrap 3.0 and jquery.

### Usage

3 grunt targets are created:

* ``grunt dev``: Use this for development. It will use require.js to load all the modules separatly. It will compile your coffeescript on the fly as you save them. This task only ends when you hit CTRL-C.

* ``grunt prod``: Use this for production. It will generate a ready for prod build of your application, with all the javascript concatenated and minified.

* ``grunt ci``: Use this for continuous integration testing. It runs the unit tests in dev and prod mode in a row.

### Examples

Granlecoja methodology has been built for the buildbot project, but is very generic, and can be used for any projects.

You can see it in action at https://github.com/buildbot/buildbot/tree/nine/www
