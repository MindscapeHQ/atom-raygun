Path = require 'path'
FindIt = require 'findit'
ArrayDifference = require 'array-difference'

module.exports =
  locateFileForError: (response, callback) ->
    initialLine = response.details.error.stackTrace[0]
    fileName = initialLine.fileName
    lineNumber = initialLine.lineNumber

    split = fileName.split('/')

    # we may get windows file paths so check for that here
    split = if split.length > 1 then split else fileName.split('\\')

    possibleFile = {}

    FindIt atom.project.getPath()
      .on 'file', (f,s) ->
        fsplit = f.split(Path.sep)
        close =
          length: ArrayDifference(split, fsplit).length
          name: f
        possibleFile = close unless possibleFile.length < close.length
      .on 'end', () ->
        if possibleFile.name
          result =
            lineNumber: lineNumber,
            fileName: possibleFile.name
          callback(result)
