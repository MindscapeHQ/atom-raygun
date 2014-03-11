{$,ScrollView} = require 'atom'

module.exports =
class ErrorGroupListView extends ScrollView
  @content: ->
    @div =>
      @div class: 'error-group-resize-handle', outlet: 'resizeHandle'
      @div =>
        @h1 'Error Group View'
        @ol outlet: 'errorList'

  initialize: (state) ->
    super

    @on 'mousedown', '.error-group-resize-handle', (e) => @resizeStarted(e)

  resizeStarted: =>
    $(document.body).on 'mousemove', @resizeView
    $(document.body).on 'mouseup', @resizeStop

  resizeStop: =>
    $(document.body).off 'mousemove', @resizeView
    $(document.body).off 'mouseup', @resizeStop

  resizeView: ({pageY}) =>
    @height($(document.body).height() - pageY)
