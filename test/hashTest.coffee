should = require 'should'

Hash = require '../src/hash'

comparator = () -> true


describe 'Hash', ->

  describe 'constructor', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, NaN, 'prototype', {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as comparator", ->
            ( -> hash = new Hash ['a'], invalid ).should.throw 'Invalid comparator'

    describe 'success', ->

      it 'should accept valid keys and comparator function', ->
        hash = new Hash ['a'], comparator
        hash.a = 1000
        should.exist hash._store
        hash._comparator.should.eql comparator

      # it 'should be enumerable', ->
      #   hash = new Hash ['key1', 'key2', 'key3'], (v) -> v instanceof Date
      #   date1 = new Date 2013, 0, 1
      #   date2 = new Date 2014, 0, 1
      #   date3 = new Date 2015, 0, 1
      #   hash.key1 = date1
      #   hash.key2 = date2
      #   hash.key3 = date3

      #   for key, value of hash._store
      #     console.log '######', key, value


# ----------------------------------------------------------------------

  describe 'setKeys', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, NaN, 'prototype', {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as keys", ->
            hash = new Hash ['a'], comparator
            ( -> hash.setKeys invalid ).should.throw 'keys must be type array'

      call() for call in ['setKeys', 'reset', 'remove', 'getData', 'keys'].map (reserved) ->
        () ->
          it "should not define an already defined key and throw: #{reserved}", ->
            hash = new Hash ['a'], comparator
            ( -> hash.setKeys reserved ).should.throw()

    describe 'success', ->

      it 'should define setter and getter for the keys', ->
        hash = new Hash ['first', 'second', 'third', '~'], (v) -> v instanceof Date
        hash.first = new Date 2013, 0, 1
        hash.second = new Date 2014, 0, 1
        should.exist hash.first
        hash.first.should.eql new Date 2013, 0, 1
        should.exist hash.second
        hash.second.should.eql new Date 2014, 0, 1


# ----------------------------------------------------------------------

  describe 'reset', ->

    it 'should reset', ->
      hash = new Hash ['first', 'second'], (v) -> v instanceof Date

      hash.first = new Date
      hash.second = new Date
      should.exist hash.first
      should.exist hash.second
      hash.reset()
      should.not.exist hash.first
      should.not.exist hash.second

# ----------------------------------------------------------------------

  describe 'remove', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date, new Object, () ->].map (invalid) ->
        () ->          
          it "should not accept #{invalid} as key", ->
            hash = new Hash ['a'], comparator
            ( -> hash.remove invalid ).should.throw 'Invalid key'

    describe 'success', ->

      it 'should return false if the key does not exist', ->
        hash = new Hash [], comparator
        value = hash.remove 'key1'
        value.should.be.false

      it 'should remove the key element', ->
        hash = new Hash ['first'], (v) -> v instanceof Date
        hash.first = new Date

        hash.remove 'first'
        should.not.exist hash.first

      it 'should return the key element', ->
        hash = new Hash ['first'], (v) -> v instanceof Date

        date = new Date
        hash.first = date

        value = hash.remove 'first'
        value.should.eql date


# ----------------------------------------------------------------------

  describe 'keys', ->

    it 'should return the data', ->
      hash = new Hash ['key1', 'key2', 'key3'], (v) -> v instanceof Date
      hash.key1 = new Date
      hash.key2 = new Date

      hash.keys().should.eql ['key1', 'key2']

# ----------------------------------------------------------------------

  describe 'length', ->

    it 'should return the correct number of keys', ->
      hash = new Hash ['key1', 'key2', 'key3'], (v) -> v instanceof Date
      hash.key1 = new Date
      hash.key2 = new Date

      hash.length.should.equal 2

# ----------------------------------------------------------------------

  describe 'getData', ->

    it 'should return the data', ->
      hash = new Hash ['key1', 'key2', 'key3'], (v) -> v instanceof Date
      date1 = new Date 2013, 0, 1
      date2 = new Date 2014, 0, 1
      date3 = new Date 2015, 0, 1
      hash.key1 = date1
      hash.key2 = date2
      hash.key3 = date3

      hash.getData().should.eql {
        key1: date1
        key2: date2
        key3: date3
      }
