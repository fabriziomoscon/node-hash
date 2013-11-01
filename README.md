# node-hash

[![Build Status](https://travis-ci.org/fabriziomoscon/node-hash.png?branch=master)](https://travis-ci.org/fabriziomoscon/node-hash)

A super simple javascript implementation of `Hash`. As far as this module is concerned, a `Hash` is a key-value pair list of objects of the same type.

A `node-hash` can be useful when you need a list of element of the same type stored by key, but you want the leave type checking outside you application code. You can inject your own `comparator` function, so `node-hash` will `throw` when a different type is assigned to a key.

This implementation doesn't try to substitute the ES6 `map` implementation, it just represents a lightweight alternative implementation.

## Install

```bash
npm install node-hash
```

## Usage

### Hash of `Date`

```JavaScript
var Hash = require( 'node-hash' );

var myDateComparator = function (value) {
  return value instanceof Date;
}

var times = new Hash(
  ['created_at', 'last_seen', 'last_modified', 'future_action_at'],
  myDateComparator
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

// get all internally store data as a key value hash
console.log( times.getData() );

// return only the used keys
assert( times.keys(), ['created_at', 'last_seen', 'last_modified'] );

// return the value of the removed key, or false if the key is not used
times.remove( 'last_modified' );

// return the used keys length
assert( times.length, 3 );

// reset the hash
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
