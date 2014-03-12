{$,$$,ScrollView} = require 'atom'
ErrorView = require './error'

module.exports =
class ErrorGroupListView extends ScrollView
  @content: ->
    @div =>
      @div class: 'error-group-resize-handle', outlet: 'resizeHandle'
      @div =>
        @h1 'Error Group View'
        @ul outlet: 'errorList'

  initialize: (state) ->
    super

    @on 'mousedown', '.error-group-resize-handle', (e) => @resizeStarted(e)
    @on 'click', '.error', (e) => @errorClicked(e)

  resizeStarted: =>
    $(document.body).on 'mousemove', @resizeView
    $(document.body).on 'mouseup', @resizeStop

  resizeStop: =>
    $(document.body).off 'mousemove', @resizeView
    $(document.body).off 'mouseup', @resizeStop

  resizeView: ({pageY}) =>
    @height($(document.body).height() - pageY)

  populateErrors: (errors) ->
    @errorList.empty()
    views = errors.map (err) ->
      new ErrorView(err)
    views.forEach((v) => @errorList.append(v))

  errorClicked: (event) ->
    view = $(event.currentTarget).view()
    @trigger 'atom-raygun:error-selected', view.errorData
