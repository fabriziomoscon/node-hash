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


  constructor: (keys = [], comparator, initialValue) ->

    throw new TypeError 'Invalid comparator' unless typeof comparator is 'function'

    @_keys = keys
    @setKeys(keys)
    @_comparator = comparator

    if initialValue?
      for key in keys
        @["#{key}"] = initialValue

    Object.defineProperty @, 'length', {
      get: () -> keys.length
    }


  setKeys: (keys) ->

    throw new TypeError 'keys must be type array' unless Array.isArray keys

    keys.forEach (key) =>

      throw new TypeError 'Invalid key' unless typeof key is 'string'
      throw new TypeError "`#{key}` is already defined" if key in Hash.RESERVED_KEY_NAMES

      Object.defineProperty Hash.prototype, key, {
        get: () => return @["_#{key}"]
        set: (value) =>
          throw new TypeError 'Invalid type of member' unless @_comparator value
          @["_#{key}"] = value
        enumerable: true
        configurable: true
      }


  reset: (value) ->
    @_keys.forEach (key) => @["_#{key}"] = value


  remove: (key) ->

    throw new TypeError 'Invalid key' unless typeof key is 'string'

    return false unless @["_#{key}"]?

    value = @["_#{key}"]

    @["_#{key}"] = undefined

    return value


  getData: () ->

    data = {}
    @_keys.forEach (key) =>
      data[key] = @["_#{key}"]

    return data

  keys: () -> return @_keys


  marshall: (marshallFunction = (v) -> v) ->

    throw new TypeError 'Invalid marshall function' unless typeof marshallFunction is 'function'

    data = {}
    @_keys.forEach (key) =>
      if @["_#{key}"]?
        data[key] = marshallFunction @["_#{key}"]

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
