# Camunda Service Task Benchmarks

This repository 

The BPM models we will use for testing are
- `bpmnservlet/src/main/resources/basic.bpmn`    - a basic use case without much computational requirements
- `bpmnservlet/src/main/resources/advanced.bpmn` - a more advanced use case to examine the effect of increasing the computational load of each service task

## Experiment variables

The experiment variables are outlined in this blog post [here](https://joeltok.com/blog/)

## Installation

### Build .war file for deployment

- Load `/bpmnservlet` into Eclipse
- Maven clean
- Maven build

### Clean build and installation of the customised docker image for each iteration

- `docker build . -t camunda-benchmarker`
- `docker run -p 3500:8080 camunda-benchmarker`