ErrorView = require '../lib/error'

describe "ErrorView", ->
  beforeEach ->
    @view = new ErrorView({ message: 'wow' })

  it "has the required text", ->
    expect(@view.find('span')).toHaveText('wow')

  it "has the required class", ->
    expect(@view).toHaveClass('error')
