{$, $$, SelectListView} = require 'atom'
api = require './raygun-api'

module.exports =
class ApplicationList extends SelectListView
  initialize: (options) ->
    super
    @addClass('overlay from-top')
    api.applications().done (response) =>
      @setItems response
    atom.workspaceView.command "atom-raygun:toggle", => @toggle()

  viewForItem: (item) ->
    $$ ->
      @li 'data-item': item, "#{item.name}"

  confirmed: (item) ->
    @cancel()
    console.log "#{item.name} was selected"

  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @cancel()
    else
      @populateList()
      atom.workspaceView.append(this)
      @focusFilterEditor()
