var assert = require('assert');

var Hash = require('../lib/Hash');


var times = new Hash(
  ['created_at', 'last_seen', 'last_modified', 'future_action_at'],
  Hash.comparator.Date,
  new Date()
);

// uses a predefined setter which will use the `comparator` function to check the value type
times.created_at = new Date();
times.last_seen = new Date();
times.last_modified = new Date();

// these will all throw
assert.throws( function() { times.last_seen = 'yesterday' } );
assert.throws( function() { times.last_seen = 100 } );
assert.throws( function() { times.last_seen = [] } );

// uses a predefined getter
console.log( times.created_at );
// Fri Aug 08 2014 11:31:04 GMT+0100 (BST)

// returns the internal key-value store
console.log( times.getData() );
/*
{
  created_at: Fri Aug 08 2014 11:31:04 GMT+0100 (BST),
  last_seen: Fri Aug 08 2014 11:31:04 GMT+0100 (BST),
  last_modified: Fri Aug 08 2014 11:31:04 GMT+0100 (BST),
  future_action_at: Fri Aug 08 2014 11:31:04 GMT+0100 (BST)
}
*/

// returns all the keys passed to the contructor
assert( times.keys(), ['created_at', 'last_seen', 'last_modified', 'future_action_at'] );

// returns the value of the removed key, or false if the key is not used
times.remove( 'last_modified' );

// returns the number of keys
assert( times.length, 4 );

// resets the hash
times.reset();
