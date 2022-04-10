#!/bin/bash

# Prepare

cd ../
docker build -f Dockerfile.camunda -t camunda-benchmarker .
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1
rm experiment-results/*
cd experiment-agent


# Java Class

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-basic-java-class" 1 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-basic-java-class" 10 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-basic-java-class" 100 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-advanced-java-class" 1 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-advanced-java-class" 10 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner-camunda.js  "camunda-advanced-java-class" 100 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1


# Node Task Client - single worker

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1


# Node Task Client - double worker

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-basic-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../camunda/task-client-node &
node ../camunda/task-client-node &
sleep 1
node runner-camunda.js  "camunda-advanced-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1




# Prepare

cd ../
docker build -f Dockerfile.zeebe -t zeebe .
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1
cd experiment-agent/

# Node Task Client Zeebe - single worker

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

# Node Task Client Zeebe - double worker

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-basic-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -p 26500-26502:26500-26502 -d zeebe &> /dev/null
sleep 15
echo Camunda Cloud Zeebe docker container running
node ../zeebe/task-client-node &
node ../zeebe/task-client-node &
sleep 1
node runner-zeebe.js  "zeebe-advanced-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep zeebe | awk '{print $1;}')
docker stop $runninginstance
sleep 1






# I actually need to be testing for events, not service tasks. Service tasks are external computations, maybe maybe order calls etc. 


# Service task CPU - Java Class (~30%) < Zeebe (~40%) < Node Task Client (~50-60%)
# But Zeebe idles at close to 10%, while Camunda idles at barely 0.5%
# And Zeebe has ELK stack requirements too -> seems like the problem with ElasticSearch is mostly one of memory (2.5 GB RAm while idling, <1.0% CPU)
# * CPU% is on 6 CPU (docker measurement)