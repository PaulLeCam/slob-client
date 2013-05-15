module.exports = (grunt) ->

  connect_port = 8888

  grunt.initConfig

    clean:
      lib: "dist"
      build: "build"

    coffee:
      lib:
        files: [
          expand: yes
          cwd: "src"
          src: "**/*.coffee"
          dest: "dist"
          ext: ".js"
        ]
      app:
        files: [
          expand: yes
          cwd: "app"
          src: "**/*.coffee"
          dest: "build"
          ext: ".js"
        ]
      "test.unit":
        files: [
          expand: yes
          cwd: "test/unit"
          src: "**/*.coffee"
          dest: "build/test/unit"
          ext: ".js"
        ]
      "test.func":
        files: [
          expand: yes
          cwd: "test/unit"
          src: "**/*.coffee"
          dest: "build/test/func"
          ext: ".js"
        ]

    handlebars:
      app:
        options:
          namespace: no
          amd: yes
        files: [
          expand: yes
          cwd: "app/templates"
          src: "**/*.htm"
          dest: "build/templates"
          ext: ".js"
        ]

    watch:
      lib:
        files: "src/**/*.coffee"
        tasks: "coffee:lib"
      "test:unit":
        files: "test:unit"
        tasks: "mocha:unit"
      # "test:func":
      #   files: "test:func"
      #   tasks: "mocha:func"

    connect:
      server:
        options:
          port: connect_port
          base: "."

    mocha:
      unit:
        options:
          urls: ["http://localhost:#{ connect_port }/test/unit.htm"]
      functional:
        options:
          urls: ["http://localhost:#{ connect_port }/test/func.htm"]

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-handlebars"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-mocha"

  grunt.registerTask "build", ["clean:lib", "coffee:lib"]

  grunt.registerTask "test:prepare", ["build", "clean:build", "coffee:app", "connect"]
  grunt.registerTask "test:unit", ["test:prepare", "coffee:test.unit", "mocha:unit"]
  grunt.registerTask "test:func", ["test:prepare", "coffee:test.func", "mocha:func"]
  grunt.registerTask "test", ["test:prepare", "test:unit", "test:func"]

  grunt.registerTask "dev", ["build", "watch:lib"]

  grunt.registerTask "default", ["build"]
