should = require 'should'

Hash = require '../src/hash'

MockClass = () ->

describe 'Hash', ->

  describe 'constructor', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, NaN, 'prototype', {}, [], new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as prototype", ->
            ( -> new Hash invalid ).should.throw 'Invalid prototype'

    describe 'success', ->

      it 'should accept a valid proto function', ->
        store = new Hash MockClass
        store._proto.should.equal MockClass


# ----------------------------------------------------------------------

  describe 'setKeys', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, NaN, 'prototype', {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as keys", ->
            store = new Hash String
            ( -> store.setKeys invalid ).should.throw 'keys must be type array'

    describe 'success', ->

      it 'should define setter and getter for the keys', ->
        store = new Hash Date
        store.setKeys ['first', 'second']
        store.first = new Date
        store.second = new Date
        should.exist store.first
        should.exist store.second


# ----------------------------------------------------------------------

  describe 'reset', ->

    it 'should reset', ->
      store = new Hash Date, ['first', 'second']

      store.first = new Date
      store.second = new Date
      should.exist store.first
      should.exist store.second
      store.reset()
      should.not.exist store.first
      should.not.exist store.second

# ----------------------------------------------------------------------

  describe 'remove', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date, new Object, () ->].map (invalid) ->
        () ->          
          it "should not accept #{invalid} as key", ->
            store = new Hash MockClass
            ( -> store.remove invalid ).should.throw 'Invalid key'

    describe 'success', ->

      it 'should return false if the key does not exist', ->
        store = new Hash MockClass
        value = store.remove 'key1'
        value.should.be.false

      it 'should remove the key element', ->
        store = new Hash Date, ['first']
        store.first = new Date

        store.remove 'first'
        should.not.exist store.first

      it 'should return the key element', ->
        store = new Hash Date, ['first']

        date = new Date
        store.first = date

        value = store.remove 'first'
        value.should.eql date
        

# ----------------------------------------------------------------------

  describe 'getKeys', ->


    it 'should return the data', ->
      store = new Hash MockClass, ['key1', 'key2', 'key3']
      store.getKeys().should.eql ['key1', 'key2', 'key3']

# ----------------------------------------------------------------------

  describe 'length', ->


    it 'should return the correct number of keys', ->
      store = new Hash MockClass, ['key1', 'key2', 'key3']
      store.length().should.equal 3

# ----------------------------------------------------------------------

  describe 'getData', ->

    store = new Hash MockClass, ['key1', 'key2', 'key3']

    it 'should return the data', ->
      mockInstance1 = new MockClass
      mockInstance2 = new MockClass
      mockInstance3 = new MockClass
      store.key1 = mockInstance1
      store.key2 = mockInstance2
      store.key3 = mockInstance3

      store.getData().should.eql {
        key1: mockInstance1
        key2: mockInstance2
        key3: mockInstance3
      }
