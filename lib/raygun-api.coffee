{$} = require 'atom'

root = "https://webapi.raygun.io"
apikey = ""
headers =
  "X-ApiKey": apikey

module.exports =
  applications: ->
    options =
      url: "#{root}/applications"
      type: "GET"
      headers: headers

    $.ajax(options)

  errors: (id) ->
    options =
      url: "#{root}/applications/#{id}/errors/active?start=0&count=20"
      type: "GET"
      headers: headers

    $.ajax(options)

  error: (id) ->
    options =
      url: "#{root}/errors/#{id}/occurrences/latest"
      type: "GET"
      headers: headers

    $.ajax(options)
