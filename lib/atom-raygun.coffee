AtomRaygunView = require './atom-raygun-view'

module.exports =
  atomRaygunView: null

  activate: (state) ->
    @atomRaygunView = new AtomRaygunView(state.atomRaygunViewState)

  deactivate: ->
    @atomRaygunView.destroy()

  serialize: ->
    atomRaygunViewState: @atomRaygunView.serialize()
