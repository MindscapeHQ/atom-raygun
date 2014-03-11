ApplicationList = require './application-list'
ErrorList = require './error-group'
Api = require './raygun-api'
Path = require 'path'

FindIt = require 'findit'

ArrayDifference = require 'array-difference'

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
      initialLine = response.details.error.stackTrace[0]
      fileName = initialLine.fileName
      lineNumber = initialLine.lineNumber

      split = fileName.split('/')

      # we may get windows file paths so check for that here
      split = if split.length > 1 then split else fileName.split('\\')

      possibleFile = {}

      FindIt atom.project.getPath()
        .on 'file', (f,s) ->
          fsplit = f.split(Path.sep)
          close =
            length: ArrayDifference(split, fsplit).length
            name: f
          possibleFile = close unless possibleFile.length < close.length
        .on 'end', () ->
          if possibleFile.name
            options =
              initialLine: lineNumber
            atom.workspace.open(possibleFile.name, options)
