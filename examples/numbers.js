var Hash = require('../lib/Hash');

var dailyStats = new Hash(
  ['min', 'max', 'avg', 'samples'],
  Hash.comparator.number
);

dailyStats.min = 0;
dailyStats.min = 10;
dailyStats.samples = 1000;
dailyStats.avg = 4.3445345;
