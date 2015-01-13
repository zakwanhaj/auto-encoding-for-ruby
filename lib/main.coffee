module.exports =

  activate: ->
    atom.commands.add 'atom-workspace',
      'auto-encoding-for-ruby:add-encoding': =>
        @createBufferEditor().add()

    atom.commands.add '.tree-view .file .name',
      'auto-encoding-for-ruby:add-encoding-file': =>
        @createProjectEditor().add(false)

    atom.commands.add '.tree-view .directory .name',
      'auto-encoding-for-ruby:add-encoding-directory': =>
        @createProjectEditor().add()

  deactivate: ->
    @bufferEditor.destroy() if @bufferEditor?
    @projectEditor.destroy() if @projectEditor?

  createBufferEditor: ->
    unless @bufferEditor
      BufferEditor = require './buffer-editor'
      @bufferEditor = new BufferEditor()
    @bufferEditor

  createProjectEditor: ->
    unless @projectEditor
      ProjectEditor = require './project-editor'
      @projectEditor = new ProjectEditor()
    @projectEditor
