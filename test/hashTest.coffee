Hash = require '../src/hash'

MockClass = () ->

describe 'Hash', ->

  describe 'constructor', ->

    describe 'failure', ->
      it 'should not accept an invlaid prototype', ->
        for invalid in [null, undefined, false, -1.1, 0, 1.1, NaN, 'prototype', {}, [], new Date, new MockClass]
          ( -> new Hash invalid ).should.throw 'Invalid prototype'

    describe 'success', ->
      it 'should accept a valid proto function', ->
        store = new Hash MockClass
        store._proto.should.equal MockClass

# ----------------------------------------------------------------------

  describe 'reset', ->
    store = new Hash MockClass
    it 'should reset', ->
      store.reset()
      store._store.should.eql {}

# ----------------------------------------------------------------------

  describe 'set', ->
    
    store = new Hash MockClass

    describe 'failures', ->

      it 'should not accept invalid keys', ->
        for invalid in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date, new MockClass]
          ( -> store.set invalid ).should.throw 'Invalid key'

      it 'should not accept invalid members', ->
        for invalid in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date]
          ( -> store.set 'key1', invalid ).should.throw 'Invalid member object'

    describe 'success', ->

      it 'should accept valid members', ->
        mockInstance = new MockClass
        store.set('key1', mockInstance)
        store._store['key1'].should.be.instanceof MockClass
        store._store['key1'].should.eql mockInstance

# ----------------------------------------------------------------------

  describe 'get', ->

    store = new Hash MockClass

    describe 'failure', ->
      it 'should not accept invalid keys', ->
        for invalid in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date, new MockClass]
          ( -> store.get invalid ).should.throw 'Invalid key'
    
    describe 'success', ->

      it 'should return null when key is not set', ->
        value = store.get 'key_not_present'
        (value is null).should.be.true
    
      it 'should return the value when the key is set', ->

        mockInstance = new MockClass
        mockInstance.x = 1
        mockInstance.y = 2

        store.set 'key1', mockInstance
        store.get('key1').should.eql mockInstance

# ----------------------------------------------------------------------

  describe 'remove', ->

    store = new Hash MockClass

    describe 'failure', ->
      it 'should not accept invalid keys', ->
        for invalid in [null, undefined, false, -1.1, 0, 1.1, NaN, '', {}, [], new Date, new MockClass]
          ( -> store.remove invalid ).should.throw 'Invalid key'

    describe 'success', ->

      it 'should return false if the key does not exist', ->
        value = store.remove 'key1'
        value.should.be.false

      it 'should remove the key element', ->
        mockInstance = new MockClass
        mockInstance.x = 1
        mockInstance.y = 2

        store.set 'key1', mockInstance
        store.remove 'key1'
        store._store.should.eql {}

      it 'should return the key element', ->
        mockInstance = new MockClass
        mockInstance.x = 1
        mockInstance.y = 2

        store.set 'key1', mockInstance
        value = store.remove 'key1'
        value.should.eql mockInstance

# ----------------------------------------------------------------------

  describe 'getKeys', ->

    store = new Hash MockClass

    it 'should return the data', ->
      mockInstance1 = new MockClass
      mockInstance2 = new MockClass
      mockInstance3 = new MockClass
      store.set 'key1', mockInstance1
      store.set 'key2', mockInstance2
      store.set 'key3', mockInstance3

      store.getKeys().should.eql ['key1', 'key2', 'key3']

# ----------------------------------------------------------------------

  describe 'count', ->

    store = new Hash MockClass

    it 'should return the correct number of keys', ->
      mockInstance1 = new MockClass
      mockInstance2 = new MockClass
      mockInstance3 = new MockClass
      store.set 'key1', mockInstance1
      store.set 'key2', mockInstance2
      store.set 'key3', mockInstance3

      store.count().should.equal 3

# ----------------------------------------------------------------------

  describe 'getData', ->

    store = new Hash MockClass

    it 'should return the data', ->
      mockInstance1 = new MockClass
      mockInstance2 = new MockClass
      mockInstance3 = new MockClass
      store.set 'key1', mockInstance1
      store.set 'key2', mockInstance2
      store.set 'key3', mockInstance3

      store.getData().should.eql {
        key1: mockInstance1
        key2: mockInstance2
        key3: mockInstance3
      }
