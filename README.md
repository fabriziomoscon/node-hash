node-hash
=========

[![Build Status](https://travis-ci.org/fabriziomoscon/node-hash.png?branch=master)](https://travis-ci.org/fabriziomoscon/node-hash)

A super simple javascript implementation of `Hash`. As far as this module is concerned, a `Hash` is an key-value pair list of objects of the same type. This implementation doesn't try to substitute the new coming ES6 implementation for maps, but represents a much more simple and lightweight implementation.

Use a node hash when you need a list of object of the same type stored by key.

Install
-------

```bash
npm install node-hash
```

Usage
-----

```JavaScript
var Hash = require( 'node-hash' );

var times = new Hash( Date );

times.set( 'opened',  new Date() );
times.set( 'written', new Date() );
times.set( 'closed',  new Date() );

assert( times.keys(), [ 'opened', 'written', 'closed' ] );

times.remove( 'written' );

assert( times.keys(), [ 'opened', 'closed' ] );
assert( times.count(), 2 );
```

test
----

```bash
npm test
```

## Development

The only dev dependency is `coffee-script` which can be installed running 'npm install' `mocha` and `should` are used in the testing suite. The coffeescript is compiled down to javascript automatically before publishing using the 'prepublish' script in 'package.json'. coffeescript files and test files are deliberately left out of the package via '.npmignore' 
because no one likes needlessly big modules.

Contributions are welcome!


License
-------

MIT
