### ###############################################################################################
#
#   Concatenate bower.json files into config.js.
#
### ###############################################################################################
module.exports = (grunt, options) ->
    banner =
        if options.config.plugin
        then "angular.module('buildbot.#{options.config.name}').constant('bower_configs', ["
        else "angular.module('buildbot.about').constant('bower_configs', ["

    bower_config:
        src: 'src/libs/**/bower.json'
        dest: '.temp/scripts/config.js'
        options:
            separator:','
            banner: banner
            footer: ']);'