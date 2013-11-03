# node-hash

[![Build Status](https://travis-ci.org/fabriziomoscon/node-hash.png?branch=master)](https://travis-ci.org/fabriziomoscon/node-hash)

A JavaScript implementation of `Hash` data structure. As far as this module is concerned, a `Hash` is a key-value pair list of items of the same type. It supports all primitive JavaScript types and arbitrary Objects.

Use `node-hash` when you have a list of items of the same type stored by key, and you don't want to check types in you application code. You need to provide your own `comparator` function and `node-hash` will `throw` when it fails.

This implementation doesn't try to substitute the ES6 `map` implementation, it just represents a lightweight alternative implementation.

## Install

```bash
npm install node-hash
```

## Usage

 Keys must be defined at contruct time, as the library uses `Object.defineProperty` to define getter and setter correctly.

### Hash of `Date`

```JavaScript
var Hash = require( 'node-hash' );

var times = new Hash(
  ['created_at', 'last_seen', 'last_modified', 'future_action_at'],
  Hash.comparator.Date
);

// uses a predefined setter which will use the `comparator` function to check the value type
times.created_at = new Date();
times.last_seen = new Date();
times.last_modified = new Date();

// these will all throw
times.last_seen = 'yesterday'
times.last_seen = 100
times.last_seen = []

// uses a predefined getter
console.log( times.created_at );

// returns the internal key-value store
console.log( times.getData() );

// returns only the used keys
assert( times.keys(), ['created_at', 'last_seen', 'last_modified'] );

// returns the value of the removed key, or false if the key is not used
times.remove( 'last_modified' );

// returns the number of used keys
assert( times.length, 3 );

// resets the hash
times.reset();

```

### Hash of `number`

```JavaScript
var Hash = require( 'node-hash' );

var myNumberComparator = function (value) {
  return typeof value === 'number';
}

var dailyStats = new Hash(
  ['min', 'max', 'avg', 'samples'],
  myNumberComparator
);

dailyStats.min = 0;
dailyStats.min = 10;
dailyStats.samples = 1000;
dailyStats.samples = 4.3445345;
```

## test

```bash
npm test
```

## Development

The dev dependencies are `coffee-script` `mocha` and `should`. The coffeescript is compiled down to javascript automatically before publishing using the 'prepublish' script in 'package.json'. coffeescript files and test files are deliberately left out of the package via '.npmignore' because no one likes needlessly big modules.

Contributions are welcome!


## License

MIT
