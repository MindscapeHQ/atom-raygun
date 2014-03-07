ApplicationList = require './application-list'

module.exports =
  applicationListView: null

  activate: (state) ->
    unless atom.config.get('atom-raygun.apikey')
      atom.config.set('atom-raygun.apikey', '')
    @applicationListView = new ApplicationList()
    @applicationListView.on 'atom-raygun:application-selected', @applicationSelected

  deactivate: ->
    @applicationListView.destroy()

  serialize: ->

  applicationSelected: (event, item) ->
    console.log("#{item.name}")
