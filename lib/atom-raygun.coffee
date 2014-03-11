ApplicationList = require './application-list'
ErrorList = require './error-group'
Api = require './raygun-api'
ErrorGroupListView = require './error-group-list'
ErrorFileLocator = require './error-file-locator'


module.exports =
  applicationListView: null

  activate: (state) ->
    unless atom.config.get('atom-raygun.apikey')
      atom.config.set('atom-raygun.apikey', '')
    @applicationListView = new ApplicationList()
    @applicationListView.on 'atom-raygun:application-selected', (event, item) =>
      @applicationSelected(item)

  deactivate: ->
    @applicationListView.destroy()

  serialize: ->

  applicationSelected: (application) ->
    options =
      id: application.id
    view = new ErrorList(options)
    view.on 'atom-raygun:error-selected', (event, error) =>
      @errorSelected(error)
    atom.workspaceView.append(view)

  errorSelected: (error) ->
    Api.error(error.id).done (response) =>
      ErrorFileLocator.locateFileForError(response, (result) => @fileLocated(result))

  fileLocated: (result) ->
    options =
      initialLine: result.lineNumber
    atom.workspace.open(result.fileName, options)
    atom.workspaceView.appendToBottom(new ErrorGroupListView())
