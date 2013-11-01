class Hash


  constructor: (prototype, keys = []) ->

    throw new TypeError 'Invalid prototype' unless typeof prototype is 'function'

    @_proto = prototype
    @_store = {}
    @setKeys keys


  setKeys: (keys) ->

    throw new TypeError 'keys must be type array' unless Array.isArray keys

    # for key in keys
    keys.map (key) =>

      throw new TypeError 'Invalid key' unless typeof key is 'string'

      Object.defineProperty @, key, {
        get: () => return @_store[key] || null
        set: (value) =>
          throw new TypeError 'Invalid member value' unless value instanceof @_proto
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


  length: () -> return Object.keys(@_store).length


  getData: () -> return @_store


  getKeys: () -> return Object.keys(@_store)


module.exports = Hash
