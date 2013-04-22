node-hash
=========

Hash data structure for node.js written in CoffeeScript

Usage
-----

```JavaScript
var Hash = require 'node-hash';

var SpecificObj = function () {
  var name = 'specific';
}

var structure = new Hash( SpecificObj );

var obj1 = new SpecificObject();
var obj2 = new SpecificObject();
var obj3 = new SpecificObject();

structure.set( 'object1', obj1 );
structure.set( 'object2', obj2 );
structure.set( 'object3', obj3 );

assert( structure.keys(), [ 'object1', 'object2', 'object3' ] );

structure.remove( 'object2' );

assert( structure.keys(), [ 'object1', 'object3' ] );
assert( structure.count(), 2 );
```

test
----

```bash
npm test
```

License
-------

MIT