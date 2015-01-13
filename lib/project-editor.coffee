AutoEncodingForRubyEditor = require './auto-encoding-for-ruby-editor'
fs = require 'fs'

module.exports =
  class ProjectEditor extends AutoEncodingForRubyEditor

    add: (directory = true)->
      path = @selectedEntry(directory)?.getPath()
      return unless path
      @loadPath path

    loadPath: (path)->
      editor = this
      fs.lstat path, (error, stats) ->
        unless error?
          if stats.isDirectory()
            editor.loadFolder path
          else if stats.isFile()
            editor.insertText path if editor.isRubyFile(path)

    selectedEntry: (directory = true)->
      entry = if directory
          'directory'
        else
          'file'
      document.querySelector(".tree-view .#{entry}.selected")

    loadFolder: (folderPath) ->
      editor = this
      fs.readdir folderPath, (error, children=[]) ->
        path = require 'path'
        editor.loadPath path.join(folderPath, childName) for childName in children

    insertText: (file) ->
      data = fs.readFileSync(file) # read existing contents into data
      return if @encodingText == data.toString().split('\n')[0]

      fd = fs.openSync(file, 'w+')
      buffer = new Buffer(@text)
      fs.writeSync(fd, buffer, 0, buffer.length) # write our line
      fs.writeSync(fd, data, 0, data.length) # append old data
      fs.close(fd)
