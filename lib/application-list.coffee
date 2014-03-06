{$, $$, SelectListView} = require 'atom'

module.exports =
class ApplicationList extends SelectListView
  initialize: (options) ->
    super
    @addClass('overlay from-top')
    @setItems(['Hello', 'World'])
    atom.workspaceView.command "atom-raygun:toggle", => @toggle()

  viewForItem: (item) ->
    $$ ->
      @li 'data-item-name': item, "#{item}"

  confirmed: (item) ->
    @cancel()
    console.log "#{item} was selected"

  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @cancel()
    else
      @populateList()
      atom.workspaceView.append(this)
      @focusFilterEditor()
