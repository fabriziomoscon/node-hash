check = require 'check-types'

comparator = require './comparator'


class Hash


  @RESERVED_KEY_NAMES = [
    'setKeys'
    'reset'
    'remove'
    'getData'
    'keys'
  ]

  @comparator = comparator


  constructor: (keys = [], comparator) ->

    throw new TypeError 'Invalid comparator' unless typeof comparator is 'function'

    @_store = {}
    @setKeys keys
    @_comparator = comparator

    Object.defineProperty @, 'length', {
      get: () => Object.keys(@_store).length
    }


  setKeys: (keys) ->

    throw new TypeError 'keys must be type array' unless Array.isArray keys

    keys.forEach (key) =>

      throw new TypeError 'Invalid key' unless typeof key is 'string'
      throw new TypeError "`#{key}` is already defined" if key in Hash.RESERVED_KEY_NAMES

      Object.defineProperty Hash.prototype, key, {
        get: () => return @_store[key] || null
        set: (value) =>
          throw new TypeError 'Invalid type of member' unless @_comparator value
          @_store[key] = value
        enumerable: true
        configurable: true
      }


  reset: () -> @_store = {}


  remove: (key) ->

    throw new TypeError 'Invalid key' if not (typeof key is 'string') or key is ''

    return false unless @_store[key]?

    value = @_store[key]

    @_store[key] = undefined

    return value


  getData: () -> return @_store


  keys: () -> return Object.keys(@_store)


  marshall: (marshallFunction = (v) -> v) ->

    throw new TypeError 'Invalid marshall function' unless typeof marshallFunction is 'function'

    data = {}
    @keys().forEach (k) =>
      data[k] = marshallFunction @_store[k]

    return data


Hash.unmarshall = (dataHash, comparator, unmarshallFunction = (v) -> v) ->

  throw new TypeError 'Invalid dataHash' unless check.object dataHash
  throw new TypeError 'Invalid unmarshall function' unless typeof unmarshallFunction is 'function'

  hash = new Hash Object.keys(dataHash), comparator

  if dataHash? and check.object dataHash
    Object.keys(dataHash).forEach (k) =>
      hash[k] = unmarshallFunction dataHash[k]

  return hash


module.exports = Hash
