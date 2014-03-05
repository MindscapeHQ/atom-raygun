{View} = require 'atom'

module.exports =
class AtomRaygunView extends View
  @content: ->
    @div class: 'atom-raygun overlay from-top', =>
      @div "The AtomRaygun package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "atom-raygun:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "AtomRaygunView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
