{$} = require 'atom'

module.exports =
  applications: ->
    options =
      url: "https://webapi.raygun.io/applications"
      type: "GET"
      headers:
        "X-ApiKey": ""

    $.ajax(options)
