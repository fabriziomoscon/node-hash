assert = require 'assert'

Hash = require '../src/Hash'


hash = new Hash ['first', 'second', 'third'], (v) -> v instanceof Number

hash.first = new Number 1
hash.second = new Number 2
hash.third = new Number 3

console.log 'hash', hash

console.log hash.first
console.log hash.second
console.log hash.third

console.log hash.first.valueOf()
console.log hash.second.valueOf()
console.log hash.third.valueOf()

assert.equal new Number(1), hash.first.valueOf()
assert.equal new Number(2), hash.second.valueOf()
assert.equal new Number(3), hash.third.valueOf()


hash = new Hash ['first', 'second', 'third'], (v) -> 'string' is typeof v

console.log 'hash.keys()', hash.keys()
# hash.keys() [ 'first', 'second', 'third' ]

hash.first = 'Paul'
hash.second = 'John'
hash.third = 'Adam'

assert.equal 'Paul', hash.first
assert.equal 'John', hash.second
assert.equal 'Adam', hash.third

console.log 'hash.getData()', hash.getData()
# hash.getData() { first: 'Paul', second: 'John', third: 'Adam' }

hash.remove 'second'
assert.equal undefined, hash.second

console.log 'hash.keys()', hash.keys()
# hash.keys() [ 'first', 'second', 'third' ]

console.log 'hash.getData()', hash.getData()
# hash.getData() { first: 'Paul', second: undefined, third: 'Adam' }

console.log 'hash.marshall()', hash.marshall (v) -> if v? then return "My name is #{v}"
# hash.marshall() { first: 'My name is Paul', third: 'My name is Adam' }
