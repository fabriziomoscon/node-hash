assert = require 'assert'


class Hash


  constructor: (prototype, keys = []) ->

    throw new TypeError 'Invalid prototype' unless typeof prototype is 'function'

    @_proto = prototype
    @_store = {}
    @setKeys keys


  setKeys: (keys) ->

    throw new TypeError 'keys must be type array' unless Array.isArray keys

    keys.forEach (key) =>

      throw new TypeError 'Invalid key' unless typeof key is 'string'

      Object.defineProperty Hash.prototype, key, {
        get: () => return @_store[key] || null
        set: (value) =>
          console.log 'SET value', key, value.valueOf()
          throw new TypeError 'Invalid member value' unless value instanceof @_proto
          @_store[key] = value
        enumerable: true
        configurable: true
      }


a = new Hash Number, ['first', 'second', 'third']

a.first = new Number 1
a.second = new Number 2
a.third = new Number 3

console.log 'a', a

console.log a.first
console.log a.second
console.log a.third

console.log a.first.valueOf()
console.log a.second.valueOf()
console.log a.third.valueOf()

assert.equal new Number(1), a.first.valueOf()
assert.equal new Number(2), a.second.valueOf()
assert.equal new Number(3), a.third.valueOf()
