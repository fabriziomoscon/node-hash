# util = require 'util'
# most of these can be exported directly form node lib util once noce v0.12 is stable

check = require 'check-types'


module.exports = {
  Array: (v) -> check.array v
  Date: (v) -> check.date v
  Error: (v) -> v instanceof Error
  Buffer: (v) -> v instanceof Buffer
  boolean: (v) -> 'boolean' is typeof v
  number: (v) -> check.number v
  string: (v) -> check.string v
  function: (v) -> check.fn v
  undefined: (v) -> 'undefined' is typeof v
  null: (v) -> v is null
  object: (v) -> check.object v
  symbol: (v) -> 'symbol' is typeof v
  url: (v) -> check.webUrl v
}
