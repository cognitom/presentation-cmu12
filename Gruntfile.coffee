module.exports = (grunt) ->
  require('time-grunt') grunt #実行時間の可視化用プラグイン
  grunt.initConfig
    coffee: #CoffeeScriptのコンパイル
      dev:
        expand: true
        cwd: 'src/coffee/'
        src: '*.coffee'
        dest: 'int/js/'
        ext: '.js'
    less: #LESSのコンパイル
      dev:
        files:
          'int/css/custom-bootstrap.css': 'src/less/custom-bootstrap.less' #Bootstrapのカスタムビルド
    jade:
      dev:
        expand: true
        cwd: 'src/jade/'
        src: '*.jade'
        dest: 'int/html/'
        ext: '.html'
        options:
          pretty : true
          data: (dest, src) ->
            require dest.replace /^int\/html\/(.+)\.html$/, "./src/json/$1.json"
    webfont: #WebFontのビルド
      dev:
        src: 'src/icons/*.svg'
        dest: 'int/fonts/'
        destCss: 'int/css/'
        options:
          font: 'cmu'
          hashes: false
          types: 'eot,woff,ttf,svg'
          template: 'src/icons/symbols.css'
          htmlDemo: false
          ligatures: true
    cssjoin: #CSSファイルの@import処理 ※cssminでやるとバグるので
      dev:
        files:
          'int/css/style.css': ['src/css/style.css']
    concat: #ファイルの結合
      dev:
        files:
          'int/js/main.js': [
            'bower_components/modernizr/modernizr.js'
            'bower_components/jquery/jquery.js'
            'bower_components/bootstrap/dist/js/bootstrap.js'
            'int/js/style.js'
          ]
    #プロダクション用のファイル生成
    cssmin: #CSSをミニファイ
      dist:
        files:
          'dist/css/style.css': ['int/css/style.css']
    uglify: #JavaScriptをミニファイ
      dist:
        files:
          'dist/js/main.js': ['int/js/main.js']
    copy: #単純にコピーするだけのものはここで処理
      dist:
        files: [
          expand: true
          dest: 'dist/'
          cwd: 'int/'
          src: ['fonts/**']
        ,
          expand: true
          dest: 'dist/'
          cwd: 'src/'
          src: ['images/**']
        ]
      dist_html:
        options:
          process: (content, srcpath) -> content.replace(/\.\.\/src\//g, "").replace(/\.\.\//g, "")
        files: [
          expand: true
          dest: 'dist/'
          cwd: 'int/html'
          src: ['**']
        ]
    #監視用の設定
    watch:
      options:
        livereload: true
      coffee:
        files: ['src/coffee/*.coffee']
        tasks: ['coffee']
      cssjoin:
        files: ['src/css/*.css', 'src/css/modules/*.css']
        tasks: ['cssjoin']
      cssmin:
        files: ['int/css/style.css']
        tasks: ['cssmin']
      concat:
        files: ['int/js/style.js']
        tasks: ['concat']
      less:
        files: ['src/less/*.less']
        tasks: ['less']
      webfont:
        files: ['src/icons/*.svg']
        tasks: ['webfont']
      jade:
        files: ['src/jade/*.jade', 'src/json/*.json']
        tasks: ['jade']
          
  require('load-grunt-tasks')(grunt)
  
  #aliases
  grunt.registerTask 'default', [
    'coffee', 'less', 'jade', 'webfont', 'cssjoin', 'concat'
    'cssmin', 'uglify', 'copy'
  ]
  grunt.registerTask 'd', [
    'coffee', 'less', 'jade', 'webfont', 'cssjoin', 'concat'
  ]
  grunt.registerTask 'w', [
    'watch'
  ]
  