module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    coffee:
      source:
        expand: true,
        cwd: 'lib/',
        src: ['**/*.coffee'],
        dest: 'dist/',
        ext: '.js'

    watch:
      test:
        files: [
          "lib/**/*.coffee"
          "<%= mochaTest.all.src %>"
        ]
      options:
        spawn: false

    mochaTest:
      all:
        options:
          reporter: 'spec'
          clearRequireCache: true
          timeout: 5000
          ui: 'bdd'
          require: 'coffee-script/register'
          compilers: 'coffee:coffee-script/register'
        src: ['test/**/*.coffee']

  grunt.event.on 'watch', (action, filepath) ->
    grunt.config 'mochaTest.all.src', [filepath]
    grunt.task.run "mochaTest"

  grunt.registerTask "default", ["watch"]
  grunt.registerTask "build", ["coffee:source"]
