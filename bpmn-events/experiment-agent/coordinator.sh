#!/bin/bash

# Prepare

cd ../
docker build -f Dockerfile.camunda -t camunda-bpmn-events-benchmarker .
runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1
cd experiment-agent


# # Camunda


# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 500 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 600 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 700 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 800 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 900 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 1000 5000 12
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1








# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 1 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 10 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 100 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 200 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 300 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 400 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -d -p 3500:8080 camunda-bpmn-events-benchmarker &> /dev/null
# sleep 5
# curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
# echo Camunda Platform docker container running
# node runner-camunda.js  "camunda-process" 500 1000 60
# runninginstance=$(docker ps | grep camunda-bpmn-events-benchmarker | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1



# # Prepare

# cd ../
# docker build -f Dockerfile.zeebe -t zeebe .
# runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1
# cd experiment-agent/

# Zeebe

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node runner-zeebe.js  "zeebe-process" 100 5000 12
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node runner-zeebe.js  "zeebe-process" 300 5000 12
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node runner-zeebe.js  "zeebe-process" 500 5000 12
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1


# docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# sleep 15
# echo Camunda Cloud Zeebe docker container running
# node runner-zeebe.js  "zeebe-process" 1 1000 60
# runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# sleep 15
# echo Camunda Cloud Zeebe docker container running
# node runner-zeebe.js  "zeebe-process" 10 1000 60
# runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# docker stop $runninginstance
# sleep 1

# # ## beyond the below point, some processes just never complete. 

# # docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# # sleep 15
# # echo Camunda Cloud Zeebe docker container running
# # node runner-zeebe.js  "zeebe-process" 100 1000 60
# # runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# # docker stop $runninginstance
# # sleep 1

# # docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# # sleep 15
# # echo Camunda Cloud Zeebe docker container running
# # node runner-zeebe.js  "zeebe-process" 200 1000 60
# # runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# # docker stop $runninginstance
# # sleep 1

# # docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# # sleep 15
# # echo Camunda Cloud Zeebe docker container running
# # node runner-zeebe.js  "zeebe-process" 300 1000 60
# # runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# # docker stop $runninginstance
# # sleep 1

# # docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# # sleep 15
# # echo Camunda Cloud Zeebe docker container running
# # node runner-zeebe.js  "zeebe-process" 400 1000 60
# # runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# # docker stop $runninginstance
# # sleep 1

# # docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
# # sleep 15
# # echo Camunda Cloud Zeebe docker container running
# # node runner-zeebe.js  "zeebe-process" 500 1000 60
# # runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
# # docker stop $runninginstance
# # sleep 1