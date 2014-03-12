{View} = require 'atom'

module.exports =
class ErrorView extends View
  @content: ->
    @li class: 'error', =>
      @span outlet: 'message'

  initialize: (@errorData) ->
    @message.text(errorData.message)
