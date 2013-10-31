class Hash


  constructor: (prototype, keys = []) ->

    throw new TypeError 'Invalid prototype' unless typeof prototype is 'function'

    @_proto = prototype
    @_keys = []
    @setKeys keys
    @reset()


  setKeys: (keys) ->

    throw new TypeError 'keys must be type array' unless Array.isArray keys

    for key in keys
      if typeof key is 'string'
        @_keys.push key
        @.__defineGetter__( key, () => @key || null )
        @.__defineSetter__( key,
          (value) =>
            throw new TypeError 'Invalid member value' unless value instanceof @_proto
            @key = value
        )

  reset: () ->

    for key in @_keys
      @key = undefined


  remove: (key) ->

    throw new TypeError 'Invalid key' if not (typeof key is 'string') or key is ''

    return false unless @key?

    value = @key

    @key = undefined

    return value


  length: () -> return @_keys.length


  getData: () ->

    data = {}
    for key in @_keys
      data[key] = @key

    return data


  getKeys: () -> return @_keys


module.exports = Hash
