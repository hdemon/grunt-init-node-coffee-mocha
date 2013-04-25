"use strict"
module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    coffee:
      lib:
        options:
          bare: true
          sourceMap: true
        expand: true
        src: ["lib/**/*.coffee"]
        dest: "dest"
        ext: ".js"

      test:
        options:
          bare: true
        expand: true
        src: ["test/**/*.coffee"]
        dest: "test"
        ext: ".js"

    watch:
      lib:
        files: "<%= coffee.lib.src %>"
        tasks: ["coffee:lib"]

      test:
        files: "<%= coffee.test.src %>"
        tasks: ["coffee:test", "test"]

    simplemocha:
      all:
        src: ['test/**/*.coffee']
        options:
          timeout: 3000
          ignoreLeaks: false
          ui: 'tdd'
          compilers: 'coffee:coffee-script'


  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-simple-mocha"

  grunt.registerTask "default", ["watch"]
  grunt.registerTask "test", ["simplemocha"]
