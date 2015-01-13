AutoEncodingForRubyEditor = require './auto-encoding-for-ruby-editor'

module.exports =
  class BufferEditor extends AutoEncodingForRubyEditor

    add: ->
      file = atom.workspace.getActiveTextEditor()
      return unless @isRubyFile(file.getPath())
      @insertText(file)

    insertText: (file) ->
      str = file.lineTextForBufferRow(0)
      return if str == @encodingText
      file.setTextInBufferRange(new Range([0, 0]), @text)
      file.save()
