const fs = require('fs')
const axios = require('axios')
const FormData = require('form-data')

const processDefinitionKey = process.argv[2]
const concurrentProcesses = Number(process.argv[3])
const interval = process.argv[4]
const eventsPerProcess = process.argv[5]
const filenameAppend = process.argv[6]

let repetitionNumber = 0
let numFailures = 0

console.log(`
Run with parameters: 
processDefinitionKey: ${processDefinitionKey}
concurrentProcesses: ${concurrentProcesses}
eventsPerProcess: ${eventsPerProcess}
`)

function sleep (timeout) {
  return new Promise(resolve => setTimeout(resolve, timeout));
}

async function uploadDeployments () {
  const form = new FormData();
  form.append(`${processDefinitionKey}.bpmn`, fs.createReadStream(`../camunda/bpmnservlet/src/main/resources/${processDefinitionKey}.bpmn`));
  
  await axios({
    method: 'POST',
    url: `http://localhost:3500/engine-rest/deployment/create`,
    headers: form.getHeaders(),
    data: form
  })
}

async function startProcess () {
  try {
    const { data: { id } } = await axios({
      method: 'POST',
      url: `http://localhost:3500/engine-rest/process-definition/key/${processDefinitionKey}/start`,
      headers: {
        'content-type': 'application/json'
      },
      data: {
        variables: {
          eventsPerProcess: {
            value: eventsPerProcess,
            type: 'Long',
          }
        }
      }
    })
    for (var i = 0; i < eventsPerProcess; i++) {
      await axios({
        method: 'POST',
        url: `http://localhost:3500/engine-rest/message`,
        headers: {
          'content-type': 'application/json'
        },
        data: {
          "messageName": "wait-for-event",
          "processInstanceId": id,
          "processVariables": {
            "val": {
              "value": 1,
              "type": "Long"
            }
          }
        }
      })
      await sleep(interval)
    }
  } catch (err) {
    // if failure, retry
    console.error(err)
    numFailures++
    startProcess()
  }

}

function getProcessesData () {
  return axios({
    method: 'GET',
    url: `http://localhost:3500/engine-rest/history/process-instance/?processDefinitionKey=${processDefinitionKey}`
  })
}

function countCompleted(processesData) {
  return processesData.data.filter(datum => datum.endTime !== null).length
}

async function run() {
  await uploadDeployments()

  const processIds = []
  for (var i = 0; i < concurrentProcesses; i++) {
    startProcess()
  }

  // poll for completion
  const totalProcesses = concurrentProcesses
  await sleep(5)

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
    concurrentProcesses,
    interval,
    eventsPerProcess,
    numFailures,
    processesData: processesData.data,
  }  

  const filename = `${tag}-${concurrentProcesses}-${interval}-${eventsPerProcess}` 
  fs.writeFileSync(`../experiment-results/${filename}.json`, JSON.stringify(results, null, 2), 'utf8');
  console.log('done.')
}

run()