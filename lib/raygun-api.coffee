{$} = require 'atom'

root = "https://webapi.raygun.io"
generateHeaders = ->
  headers =
    "X-ApiKey": atom.config.get('atom-raygun.apikey')

module.exports =
  applications: ->
    options =
      url: "#{root}/applications"
      type: "GET"
      headers: generateHeaders()

    $.ajax(options)

  errors: (id) ->
    options =
      url: "#{root}/applications/#{id}/errors/active?start=0&count=20"
      type: "GET"
      headers: generateHeaders()

    $.ajax(options)

  error: (id) ->
    options =
      url: "#{root}/errors/#{id}/occurrences/latest"
      type: "GET"
      headers: generateHeaders()

    $.ajax(options)
