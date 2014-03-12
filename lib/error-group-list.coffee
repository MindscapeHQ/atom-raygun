{$,$$,ScrollView} = require 'atom'
ErrorView = require './error'

module.exports =
class ErrorGroupListView extends ScrollView
  @content: ->
    @div class: 'atom-raygun', =>
      @div class: 'error-group-resize-handle', outlet: 'resizeHandle'
      @div class: 'raygun-results', =>
        @h1 'Choose Application first', outlet: 'heading'
        @ul outlet: 'errorList'

  initialize: (state) ->
    super

    atom.workspaceView.command "atom-raygun:toggle-errors", => @toggle()
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

  populateErrors: (application, errors) ->
    @heading.text "#{application.name} Errors"
    @errorList.empty()
    views = errors.map (err) ->
      new ErrorView(err)
    views.forEach((v) => @errorList.append(v))

  errorClicked: (event) ->
    view = $(event.currentTarget).view()
    @trigger 'atom-raygun:error-selected', view.errorData

  toggle: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.appendToBottom(this)
