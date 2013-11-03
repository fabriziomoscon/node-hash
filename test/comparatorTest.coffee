comparator = require '../src/comparator'

describe 'comparator', ->

  describe 'Date', ->

    call() for call in [null, undefined, false, 1, NaN, [], {}, new Object, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.Date(invalid).should.be.false

    it 'should return true for instanceof Date', ->
      comparator.Date(new Date).should.be.true
