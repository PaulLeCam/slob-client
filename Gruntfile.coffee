module.exports = (grunt) ->
  grunt.initConfig

    dir:
      components: "components"
      assets: "assets"
      code: "src"
      widgets: "widgets"
      build:
        root: "build"
        css: "build/css"
        js: "build/js"
        templates: "build/js/templates"
        widgets: "build/js/widgets"
      dist:
        root: "dist"
        css: "dist/css"
        js: "dist/js"
        widgets: "dist/widgets"

    clean:
      build: "<%= dir.build.root %>"
      dist: "<%= dir.dist.root %>"
      widgets: "<%= dir.dist.widgets %>/*/*"

    copy:
      components:
        files: [
          {src: "<%= dir.components %>/requirejs/require.js", dest: "<%= dir.build.js %>/lib/requirejs.js"}
          {src: "<%= dir.components %>/json3/lib/json3.js", dest: "<%= dir.build.js %>/lib/json3.js"}
          {src: "<%= dir.components %>/jquery/jquery.js", dest: "<%= dir.build.js %>/lib/jquery.js"}
          {src: "<%= dir.components %>/backbone/backbone.js", dest: "<%= dir.build.js %>/lib/backbone.js"}
          {src: "<%= dir.components %>/lodash/dist/lodash.compat.js", dest: "<%= dir.build.js %>/lib/lodash.js"}
          {src: "<%= dir.components %>/handlebars/handlebars.runtime.js", dest: "<%= dir.build.js %>/lib/handlebars.js"}
        ]
      assets:
        files: [
          expand: yes
          cwd: "<%= dir.assets %>"
          src: "**"
          dest: "<%= dir.build.root %>"
        ]

    coffee:
      code:
        files: [
          expand: yes
          cwd: "<%= dir.code %>"
          src: "**/*.coffee"
          dest: "<%= dir.build.js %>"
          ext: ".js"
        ]
      widgets:
        files: [
          expand: yes
          cwd: "<%= dir.widgets %>"
          src: "**/*.coffee"
          dest: "<%= dir.build.widgets %>"
          ext: ".js"
        ]

    handlebars:
      widgets:
        options:
          namespace: no
          amd: yes
        files: [
          expand: yes
          cwd: "<%= dir.widgets %>"
          src: "*/templates/*.htm"
          dest: "<%= dir.build.widgets %>"
          ext: ".js"
        ]

    watch:
      code:
        files: "<%= dir.code %>/**/*.coffee"
        tasks: "coffee:code"
      widgets_code:
        files: "<%= dir.widgets %>/**/*.coffee"
        tasks: "coffee:widgets"
      widgets_templates:
        files: "<%= dir.widgets %>/*/templates/*.htm"
        tasks: "handlebars:widgets"

    cssmin:
      prod:
        files: [
          expand: yes
          cwd: "<%= dir.build.css %>"
          src: "**/*.css"
          dest: "<%= dir.dist.css %>"
        ]

    requirejs:
      compile:
        options:
          baseUrl: "<%= dir.build.js %>"
          mainConfigFile: "<%= dir.build.js %>/config.js"
          dir: "<%= dir.dist.js %>"
          modules: [
            {
              name: "app"
            }
          ]

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-handlebars"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-requirejs"

  grunt.registerTask "build", ["clean:build", "copy", "coffee", "handlebars"]
  grunt.registerTask "dev", ["build", "watch"]
  grunt.registerTask "prod", ["build", "clean:dist", "cssmin", "requirejs", "clean:widgets"]
  grunt.registerTask "default", ["prod"]
