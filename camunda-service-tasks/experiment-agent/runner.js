const fs = require('fs')
const axios = require('axios')

const processDefinitionKey = process.argv[2]
const concurrent = process.argv[3]
const interval = process.argv[4]
const repetition = process.argv[5]

let repetitionNumber = 0

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

function startProcess () {
  return axios({
    method: 'POST',
    url: `http://localhost:3500/engine-rest/process-definition/key/${processDefinitionKey}/start`,
    headers: {
      'content-type': 'application/json'
    }
  })
}

function getProcessesData () {
  return axios({
    method: 'GET',
    url: `http://localhost:3500/engine-rest/history/process-instance/?processDefinitionKey=${processDefinitionKey}`
  })
}

function perRepetition () {
  console.log(`Repetition ${++repetitionNumber}`)
  for (var i = 0; i < concurrent; i++) {
    startProcess()
  }
}

async function run() {
  // fire all necessary calls
  for (var i = 0; i < repetition; i++) {
    setTimeout(perRepetition, interval * (i-1))
  }

  // poll for completion
  const totalProcesses = concurrent * repetition
  await sleep(interval * (repetition-1))
  
  let processesData = await getProcessesData()
  while (processesData.data.length < totalProcesses) {
    await sleep(1000)
    console.log('waiting for completion...')
    processesData = await getProcessesData()
  }

  const results = {
    processDefinitionKey,
    concurrent,
    interval,
    repetition,
    processesData: processesData.data,
  }  

  const filename = `${processDefinitionKey}-${concurrent}-${interval}-${repetition}`
  fs.writeFileSync(`../experiment-results/${filename}.json`, JSON.stringify(results, null, 2), 'utf8');
  console.log('done.')
}

run()