const { ZBClient } = require('zeebe-node')

// create a Client instance with custom configuration
const zbc = new ZBClient();

zbc.createWorker(null, 'nodeServiceTaskBasic', (job, complete) => {
  const summed = 1 + 1
  complete.success()
})

function factorial(n) {
  if (n == 0) {
    return 1;
  }
  return n * factorial(n - 1);
}

zbc.createWorker(null, 'nodeServiceTaskAdvanced', (job, complete) => {
  // run a loop of a factorial of 20 to simulate an intensive calculation
  for (var i = 0; i < 10000000; i++) {
    factorial(20);
  }	
  complete.success()
})
