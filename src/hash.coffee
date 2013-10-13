class Hash


  constructor: (prototype) ->

    throw new TypeError 'Invalid prototype' unless typeof prototype is 'function'

    @_proto = prototype
    @reset()


  reset: ->
    @_store = {}


  set: (key, object) ->

    throw new TypeError 'Invalid key' if not (typeof key is 'string') or key is ''
    throw new TypeError 'Invalid member object' unless object instanceof @_proto

    @_store[key] = object


  get: (key) ->
    throw new TypeError 'Invalid key' if not (typeof key is 'string') or key is ''
    return @_store[key] || null


  remove: (key) ->
    throw new TypeError 'Invalid key' if not (typeof key is 'string') or key is ''
    return false unless @_store[key]?

    value = @_store[key]

    delete @_store[key]

    return value


  count: -> return @getKeys().length

  getData: -> return @_store

  getKeys: -> return Object.keys @_store


module.exports = Hash
