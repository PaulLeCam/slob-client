module.exports = (grunt) ->

  grunt.initConfig

    clean:
      lib: "dist"

    coffee:
      lib:
        files: [
          expand: yes
          cwd: "src"
          src: "**/*.coffee"
          dest: "dist"
          ext: ".js"
        ]

    watch:
      lib:
        files: "src/**/*.coffee"
        tasks: "coffee:lib"

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "build", ["clean:lib", "coffee:lib"]
  grunt.registerTask "dev", ["build", "watch:lib"]

  grunt.registerTask "default", ["build"]
