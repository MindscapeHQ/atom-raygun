{$, $$, SelectListView} = require 'atom'
api = require './raygun-api'

module.exports =
class ErrorGroupList extends SelectListView
  initialize: (options) ->
    super
    @addClass('overlay from-top')
    api.errors(options.id).done (response) =>
      @setItems response.records
      @focusFilterEditor()

  getFilterKey: ->
    return 'message'

  viewForItem: (item) ->
    $$ ->
      @li 'data-item': item, "#{item.message}"

  confirmed: (item) ->
    @cancel()
    @trigger('atom-raygun:error-selected', item)
