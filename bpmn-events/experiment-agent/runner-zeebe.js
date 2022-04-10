const { ZBClient } = require('zeebe-node')
const zbc = new ZBClient();

const fs = require('fs')

const processDefinitionKey = process.argv[2]
const concurrent = Number(process.argv[3])
const interval = Number(process.argv[4])
const eventsPerProcess = Number(process.argv[5])
const filenameAppend = process.argv[6]

let eventsPerProcessNumber = 0
let numFailures = 0

console.log(`
Run with parameters: 
processDefinitionKey: ${processDefinitionKey}
concurrent: ${concurrent}
interval: ${interval} ms
eventsPerProcess: ${eventsPerProcess}
`)

function sleep (timeout) {
  return new Promise(resolve => setTimeout(resolve, timeout));
}

const startingTimes = []
const endingTimes = []

zbc.createWorker(null, 'zeebeEndMarker', (job, complete) => {
  endingTimes.push(new Date())
  complete.success()
})

async function startProcess (processIndex) {
  await sleep(processIndex / concurrent * 1000)

  while (true) {
    try {
      await zbc.createProcessInstance(processDefinitionKey, {
        processIndex,
        eventsPerProcess,
      })
      const start = new Date()
      startingTimes.push(start)
      break
    } catch (err) {
      console.log(err)
    }
  }

  let i = 0
  while (true) {
    try {
      await zbc.publishMessage({
        "correlationKey": processIndex,
        "name": "wait-for-event",
        "variables": {
          "val": i+1,
        }
      })
      await sleep(interval)
      i++
    } catch (err) {
      // if failure, retry
      numFailures++
    }
    if (i === eventsPerProcess + 10) break;
  }
}

async function run() {
  await zbc.deployProcess('../zeebe/zeebe-process.bpmn')

  // fire all necessary calls
  for (var i = 0; i < concurrent; i++) {
    startProcess(i)
  }

  // poll for completion
  const totalProcesses = concurrent
  let allCompleted = false
  while (!allCompleted) {
    await sleep(5000)
    completedCount = endingTimes.length
    allCompleted = completedCount === totalProcesses
    console.log(`${new Date()} Waiting for completion... ${completedCount} / ${totalProcesses}`)
  }

  let totalDurationInMs = 0
  for (var i = 0; i < concurrent; i++) {
    totalDurationInMs = totalDurationInMs + (endingTimes[0] - startingTimes[0])
  }
  const averageDurationInMs = totalDurationInMs / concurrent

  const tag = processDefinitionKey + (filenameAppend ? `-${filenameAppend}` : '')
  const results = {
    tag,
    processDefinitionKey,
    concurrent,
    interval,
    eventsPerProcess,
    numFailures,
    averageDurationInMs,
    startingTimes,
    endingTimes,
  }

  const filename = `${tag}-${concurrent}-${interval}-${eventsPerProcess}` 
  fs.writeFileSync(`../experiment-results/${filename}.json`, JSON.stringify(results, null, 2), 'utf8');
  console.log('done.')
  process.exit()
}

run()