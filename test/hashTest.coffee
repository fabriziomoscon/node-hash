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
        store = new Hash Date
        store._proto.should.equal Date


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
        store = new Hash Date, ['first', 'second', 'third']
        store.first = new Date 2013, 0, 1
        store.second = new Date 2014, 0, 1
        should.exist store.first
        store.first.should.eql new Date 2013, 0, 1
        should.exist store.second
        store.second.should.eql new Date 2014, 0, 1


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
            store = new Hash Date
            ( -> store.remove invalid ).should.throw 'Invalid key'

    describe 'success', ->

      it 'should return false if the key does not exist', ->
        store = new Hash Date
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
      store = new Hash Date, ['key1', 'key2', 'key3']
      store.key1 = new Date
      store.key2 = new Date

      store.getKeys().should.eql ['key1', 'key2']

# ----------------------------------------------------------------------

  describe 'length', ->


    it 'should return the correct number of keys', ->
      store = new Hash Date, ['key1', 'key2', 'key3']
      store.key1 = new Date
      store.key2 = new Date

      store.length().should.equal 2

# ----------------------------------------------------------------------

  describe 'getData', ->

    store = new Hash Date, ['key1', 'key2', 'key3']

    it 'should return the data', ->
      date1 = new Date 2013, 0, 1
      date2 = new Date 2014, 0, 1
      date3 = new Date 2015, 0, 1
      store.key1 = date1
      store.key2 = date2
      store.key3 = date3

      store.getData().should.eql {
        key1: date1
        key2: date2
        key3: date3
      }
