ApplicationList = require './application-list'
ErrorList = require './error-group'

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
    console.log "#{error.message}"
