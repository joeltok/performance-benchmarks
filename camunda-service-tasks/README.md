# Camunda Service Task Benchmarks

This repository 

The BPM models we will use for testing are
- `bpmnservlet/src/main/resources/basic.bpmn`    - a basic use case without much computational requirements
- `bpmnservlet/src/main/resources/advanced.bpmn` - a more advanced use case to examine the effect of increasing the computational load of each service task

## Experiment variables

The experiment variables are outlined in this blog post [here](https://joeltok.com/blog/)

## Prerequisites

- Eclipse with Java 1.8 and Maven 3.3
- NodeJS v14.15.x
- Yarn v1.22

## Installation

### Build .war file for deployment

- Load `/bpmnservlet` into Eclipse
- Maven clean
- Maven build

### Install modules for agent and respective task clients

- `cd experiment-agent && yarn`
- `cd task-client-node && yarn`
- `cd task-client-python` and `python3 -m venv ./venv` and `pip3 install camunda-external-task-client-python3==4.0.0`

### Clean build and installation of the customised docker image for each iteration

- `docker build . -t camunda-benchmarker`
- `docker run -p 3500:8080 camunda-benchmarker`

### Run experiment

The experiment coordinator is found in `experiment-agent/coordinator.sh`. This is a bash file that handles spinning up and cleaning the docker container housing the Camunda Platform, as well as runs the performance test runner `experiment-agent/runner.js` for each iteration of the experiment. 