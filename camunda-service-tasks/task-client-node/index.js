const { Client, logger } = require("camunda-external-task-client-js");

// configuration for the Client:
//  - 'baseUrl': url to the Process Engine
//  - 'logger': utility to automatically log important events
const config = { baseUrl: "http://localhost:3500/engine-rest" };

// create a Client instance with custom configuration
const client = new Client(config);

client.subscribe("nodeServiceTaskBasic", async function({ task, taskService }) {
  const summed = 1 + 1
  await taskService.complete(task);
});

function factorial(n) {
  if (n == 0) {
    return 1;
  }
  return n * factorial(n - 1);
}

client.subscribe("nodeServiceTaskAdvanced", async function({ task, taskService }) {
  // run a loop of a factorial of 20 to simulate an intensive calculation
  for (var i = 0; i < 10000000; i++) {
    factorial(20);
  }	

  await taskService.complete(task);
});