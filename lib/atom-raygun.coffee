ApplicationList = require './application-list'
Api = require './raygun-api'
ErrorGroupListView = require './error-group-list'
ErrorFileLocator = require './error-file-locator'


module.exports =
  applicationListView: null
  errorGroupListView: null

  activate: (state) ->
    unless atom.config.get('atom-raygun.apikey')
      atom.config.set('atom-raygun.apikey', '')
    atom.workspaceView.command "atom-raygun:toggle-errors", => @toggleErrorsView()
    @applicationListView = new ApplicationList()
    @errorGroupListView = new ErrorGroupListView()
    @applicationListView.on 'atom-raygun:application-selected', (event, item) =>
      @applicationSelected(item)
    @errorGroupListView.on 'atom-raygun:error-selected', (event, item) =>
      @errorSelected(item)

  deactivate: ->
    @applicationListView.destroy()
    @errorGroupListView.destroy()

  serialize: ->

  toggleErrorsView: ->
    if @errorGroupListView.hasParent()
      @errorGroupListView.detach()
    else
      atom.workspaceView.appendToBottom(@errorGroupListView)

  applicationSelected: (application) ->
    Api.errors(application.id).done (response) =>
      @errorGroupListView.populateErrors(application, response.records)
      if !@errorGroupListView.hasParent()
        atom.workspaceView.appendToBottom(@errorGroupListView)

  errorSelected: (error) ->
    Api.error(error.id).done (response) =>
      ErrorFileLocator.locateFileForError(response, (result) => @fileLocated(result))

  fileLocated: (result) ->
    options =
      initialLine: result.lineNumber
    atom.workspace.open(result.fileName, options)
