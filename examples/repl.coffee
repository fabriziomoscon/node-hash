assert = require 'assert'

Hash = require '../src/Hash'


a = new Hash ['first', 'second', 'third'], (v) -> v instanceof Number

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
