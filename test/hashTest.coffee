should = require 'should'

Hash = require '../src/Hash'


describe 'Hash', ->

  describe 'constructor', ->

    describe 'failure', ->

      call() for call in [null, undefined, false, -1.1, NaN, 'prototype', {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as comparator", ->
            ( -> hash = new Hash ['a'], invalid ).should.throw 'Invalid comparator'

    describe 'success', ->

      it 'should accept valid keys and comparator function', ->
        hash = new Hash ['a'], Hash.comparator.string
        hash.a = 'a simple string'
        should.exist hash._store
        hash._comparator.should.eql Hash.comparator.string

      # it 'should be enumerable', ->
      #   hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
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
            hash = new Hash ['a'], Hash.comparator.string
            ( -> hash.setKeys invalid ).should.throw 'keys must be type array'

      call() for call in ['setKeys', 'reset', 'remove', 'getData', 'keys'].map (reserved) ->
        () ->
          it "should not define an already defined key and throw: #{reserved}", ->
            hash = new Hash ['a'], Hash.comparator.string
            ( -> hash.setKeys reserved ).should.throw()

    describe 'success', ->

      it 'should define setter and getter for the keys', ->
        hash = new Hash ['first', 'second', 'third', '~'], Hash.comparator.Date
        hash.first = new Date 2013, 0, 1
        hash.second = new Date 2014, 0, 1
        should.exist hash.first
        hash.first.should.eql new Date 2013, 0, 1
        should.exist hash.second
        hash.second.should.eql new Date 2014, 0, 1


# ----------------------------------------------------------------------

  describe 'reset', ->

    it 'should reset', ->
      hash = new Hash ['first', 'second'], Hash.comparator.Date

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
            hash = new Hash ['a'], Hash.comparator.string
            ( -> hash.remove invalid ).should.throw 'Invalid key'

    describe 'success', ->

      it 'should return false if the key does not exist', ->
        hash = new Hash [], Hash.comparator.string
        value = hash.remove 'key1'
        value.should.be.false

      it 'should remove the key element', ->
        hash = new Hash ['first'], Hash.comparator.Date
        hash.first = new Date

        hash.remove 'first'
        should.not.exist hash.first

      it 'should return the key element', ->
        hash = new Hash ['first'], Hash.comparator.Date

        date = new Date
        hash.first = date

        value = hash.remove 'first'
        value.should.eql date


# ----------------------------------------------------------------------

  describe 'keys', ->

    it 'should return the data', ->
      hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
      hash.key1 = new Date
      hash.key2 = new Date

      hash.keys().should.eql ['key1', 'key2']

# ----------------------------------------------------------------------

  describe 'length', ->

    it 'should return the correct number of keys', ->
      hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
      hash.key1 = new Date
      hash.key2 = new Date

      hash.length.should.equal 2

# ----------------------------------------------------------------------

  describe 'getData', ->

    it 'should return the data', ->
      hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
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

# ----------------------------------------------------------------------

  describe 'marshall', ->

    describe 'failures', ->

      call() for call in [false, 1, NaN, '', [], {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as marshall function", ->
            hash = new Hash ['a'], Hash.comparator.string
            (-> hash.marshall invalid).should.throw 'Invalid marshall function'

    describe 'default', ->

      call() for call in [null, undefined].map (def) ->
        () ->
          it "should accept #{def} as marshall function", ->
            hash = new Hash ['a'], Hash.comparator.string
            (-> hash.marshall def).should.not.throw()

    describe 'success', ->

      it 'should marshall the hash into plain object', ->
        hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
        date1 = new Date 2013, 0, 1
        date2 = new Date 2014, 0, 1
        date3 = new Date 2015, 0, 1
        hash.key1 = date1
        hash.key2 = date2
        hash.key3 = date3

        data = hash.marshall()
        data.should.eql {
          key1: date1
          key2: date2
          key3: date3
        }

      it 'should use a provider funciton to marshall', ->
        hash = new Hash ['key1', 'key2', 'key3'], Hash.comparator.Date
        date1 = new Date 2013, 0, 1
        date2 = new Date 2014, 0, 1
        date3 = new Date 2015, 0, 1
        hash.key1 = date1
        hash.key2 = date2
        hash.key3 = date3

        data = hash.marshall (d) -> d.getTime()
        data.should.eql {
          key1: date1.getTime()
          key2: date2.getTime()
          key3: date3.getTime()
        }

# ----------------------------------------------------------------------

  describe 'unmarshall', ->

    describe 'failures', ->

      call() for call in [false, 1, NaN, '', [], {}, new Object, new Date].map (invalid) ->
        () ->
          it "should not accept #{invalid} as unmarshall function", ->
            (-> Hash.unmarshall {}, Hash.comparator.string, invalid).should.throw 'Invalid unmarshall function'

    describe 'default', ->

      call() for call in [null, undefined].map (def) ->
        () ->
          it "should accept #{def} as unmarshall function", ->
            (-> Hash.unmarshall {}, Hash.comparator.string, def).should.not.throw()

    describe 'success', ->

      it 'should unmarshall a plain object into hash', ->
        date1 = new Date 2013, 0, 1
        date2 = new Date 2014, 0, 1
        date3 = new Date 2015, 0, 1
        data = {
          key1: date1
          key2: date2
          key3: date3
        }

        hash = Hash.unmarshall data, Hash.comparator.Date
        hash.getData().should.eql data
        hash._comparator.should.eql Hash.comparator.Date

      it 'should use a provided function to unmarshall', ->
        date1 = new Date 2013, 0, 1
        date2 = new Date 2014, 0, 1
        date3 = new Date 2015, 0, 1
        data = {
          key1: date1.getTime()
          key2: date2.getTime()
          key3: date3.getTime()
        }

        hash = Hash.unmarshall data, Hash.comparator.Date, (time) -> new Date(time)
        hash.getData().should.eql {
          key1: date1
          key2: date2
          key3: date3
        }
        hash._comparator.should.eql Hash.comparator.Date
