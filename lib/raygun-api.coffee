{$} = require 'atom'

root = "https://webapi.raygun.io"
apikey = ""

module.exports =
  applications: ->
    options =
      url: "#{root}/applications"
      type: "GET"
      headers:
        "X-ApiKey": apikey

    $.ajax(options)

  errors: (id) ->
    options =
      url: "#{root}/applications/#{id}/errors/active?start=0&count=20"
      type: "GET"
      headers:
        "X-ApiKey": apikey

    $.ajax(options)
