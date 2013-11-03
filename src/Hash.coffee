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



module.exports = Hash
