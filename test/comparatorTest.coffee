comparator = require('../src/Hash').comparator


describe 'comparator', ->

  describe 'Array', ->

    call() for call in [null, undefined, false, 1, NaN, '', {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.Array(invalid).should.be.false

    it 'should return true for instanceof Array', ->
      comparator.Array([]).should.be.true
      comparator.Array(new Array).should.be.true

# ---------------------------------------------------------------

  describe 'Date', ->

    call() for call in [null, undefined, false, 1, NaN, '', [], {}, new Object, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.Date(invalid).should.be.false

    it 'should return true for instanceof Date', ->
      comparator.Date(new Date).should.be.true

# --------------------------------------------------------------

  describe 'Error', ->

    call() for call in [null, undefined, false, 1, NaN, '', [], {}, new Object, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.Error(invalid).should.be.false

    it 'should return true for instanceof Error', ->
      comparator.Error(new Error).should.be.true
      comparator.Error(new Error 'some error').should.be.true

# --------------------------------------------------------------

  describe 'Buffer', ->

    call() for call in [null, undefined, false, 1, NaN, '', [], {}, new Object, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.Buffer(invalid).should.be.false

    it 'should return true for instanceof Buffer', ->
      comparator.Buffer(new Buffer 1000).should.be.true
      comparator.Buffer(new Buffer []).should.be.true
      comparator.Buffer(new Buffer 'some buffer').should.be.true

# ---------------------------------------------------------------

  describe 'boolean', ->

    call() for call in [null, undefined, 1, NaN, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.boolean(invalid).should.be.false

    it 'should return true for boolean', ->
      comparator.boolean(true).should.be.true
      comparator.boolean(false).should.be.true

# ---------------------------------------------------------------

  describe 'number', ->

    call() for call in [null, undefined, false, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.number(invalid).should.be.false

    it 'should return true for number', ->
      comparator.number(1).should.be.true
      comparator.number(-10).should.be.true
      comparator.number(1.1).should.be.true
      comparator.number(0x1234).should.be.true
      comparator.number(Infinity).should.be.true
      comparator.number(-Infinity).should.be.true

# ---------------------------------------------------------------

  describe 'string', ->

    call() for call in [null, undefined, false, 1, NaN, [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.string(invalid).should.be.false

    it 'should return true for string', ->
      comparator.string('').should.be.true
      comparator.string('this is a string').should.be.true

# ---------------------------------------------------------------

  describe 'function', ->

    call() for call in [null, undefined, false, 1, NaN, '', [], {}, new Object, new Date].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.function(invalid).should.be.false

    it 'should return true for function', ->
      comparator.function(()->).should.be.true
      comparator.function(Object).should.be.true
      comparator.function(Date).should.be.true
      comparator.function(String).should.be.true
      comparator.function(Number).should.be.true
      comparator.function(Array).should.be.true

# ---------------------------------------------------------------

  describe 'undefined', ->

    call() for call in [null, false, 1, NaN, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.undefined(invalid).should.be.false

    it 'should return true for undefined', ->
      comparator.undefined(undefined).should.be.true
      comparator.undefined().should.be.true

# ---------------------------------------------------------------

  describe 'null', ->

    call() for call in [undefined, false, 1, NaN, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.null(invalid).should.be.false

    it 'should return true for null', ->
      comparator.null(null).should.be.true

# ---------------------------------------------------------------

  describe 'object', ->

    call() for call in [undefined, false, 1, NaN, '', () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.object(invalid).should.be.false

    it 'should return true for object', ->
      comparator.object(new () ->).should.be.true
      comparator.object(new Object).should.be.true
      comparator.object({}).should.be.true

# ---------------------------------------------------------------

# TODO test symbol

# ---------------------------------------------------------------

  describe 'url', ->

    call() for call in [null, undefined, false, 1, NaN, '', [], {}, new Object, new Date, () ->].map (invalid) ->
      () ->
        it "should return false for #{invalid}", ->
          comparator.url(invalid).should.be.false

    it 'should return true for url', ->
      comparator.url('http://www.domain.com').should.be.true
      comparator.url('http://domain.com').should.be.true
      comparator.url('https://www.domain.com').should.be.true
      comparator.url('http://www.domain.com/path').should.be.true
      comparator.url('http://www.domain.com/path#anchor').should.be.true
      comparator.url('http://www.domain.com/path/?v=1&b=3#anchor').should.be.true

