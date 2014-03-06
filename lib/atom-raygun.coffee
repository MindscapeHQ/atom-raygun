ApplicationList = require './application-list'

module.exports =
  applicationListView: null

  activate: (state) ->
    @applicationListView = new ApplicationList();

  deactivate: ->
    @applicationListView.destroy()

  serialize: ->
