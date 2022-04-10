const { ZBClient } = require('zeebe-node')
const zbc = new ZBClient();

const fs = require('fs')

const processDefinitionKey = process.argv[2]
const concurrent = process.argv[3]
const interval = process.argv[4]
const repetition = process.argv[5]
const filenameAppend = process.argv[6]

let repetitionNumber = 0
let numFailures = 0

console.log(`
Run with parameters: 
processDefinitionKey: ${processDefinitionKey}
concurrent: ${concurrent}
interval: ${interval} ms
repetition: ${repetition}
`)

function sleep (timeout) {
  return new Promise(resolve => setTimeout(resolve, timeout));
}

const processesData = []

async function startProcess (repetitionNumber, concurrentNumber) {
  try {
    const start = new Date()
    // returns when the process completes, so we can just assume the "runtime" is the duration
    await zbc.createProcessInstanceWithResult(processDefinitionKey, {})
    const end = new Date()
    processesData.push({
      "durationInMillis": end - start,
    })
  } catch (err) {
    // if failure, retry
    numFailures++
    startProcess(repetitionNumber, concurrentNumber)
  }

}

function getProcessesData () {
  return processesData
}

function perRepetition () {
  console.log(`Repetition ${++repetitionNumber}`)
  for (var n = 1; n <= concurrent; n++) {
    const concurrentNumber = n
    setTimeout(() => {
      startProcess(repetitionNumber, concurrentNumber)
    }, n / interval)
  }
}

function countCompleted(processesData) {
  return processesData.length
}

async function run() {
  await zbc.deployProcess('../zeebe/basic-node-task-client.bpmn')
  await zbc.deployProcess('../zeebe/advanced-node-task-client.bpmn')

  // fire all necessary calls
  for (var i = 0; i < repetition; i++) {
    setTimeout(perRepetition, interval * i)
  }

  // poll for completion
  const totalProcesses = concurrent * repetition
  await sleep(interval * repetition)
  let processesData = await getProcessesData()
  let completedCount = countCompleted(processesData)
  let allCompleted = completedCount === totalProcesses
  while (!allCompleted) {
    await sleep(5000)
    processesData = await getProcessesData()
    completedCount = countCompleted(processesData)
    allCompleted = completedCount === totalProcesses
    console.log(`${new Date()} Waiting for completion... ${completedCount} / ${totalProcesses}`)
  }
  const tag = processDefinitionKey + (filenameAppend ? `-${filenameAppend}` : '')
  const results = {
    tag,
    processDefinitionKey,
    concurrent,
    interval,
    repetition,
    numFailures,
    processesData: processesData,
  }

  const filename = `${tag}-${concurrent}-${interval}-${repetition}` 
  fs.writeFileSync(`../experiment-results/${filename}.json`, JSON.stringify(results, null, 2), 'utf8');
  console.log('done.')
}

run()