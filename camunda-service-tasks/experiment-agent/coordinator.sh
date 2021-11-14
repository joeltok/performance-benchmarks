#!/bin/bash

# Prepare

cd ../
docker build . -t camunda-benchmarker
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
node runner.js  "basic-java-class" 1 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "basic-java-class" 10 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "basic-java-class" 100 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "advanced-java-class" 1 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "advanced-java-class" 10 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "advanced-java-class" 100 1000 60
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1


# Node Task Client - single worker

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 1 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 10 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 100 1000 60 "single-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1


# Node Task Client - double worker

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "basic-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 1 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 10 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1

docker run -d -p 3500:8080 camunda-benchmarker &> /dev/null
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node ../task-client-node &
node ../task-client-node &
sleep 1
node runner.js  "advanced-node-task-client" 100 1000 60 "double-worker"
ps -ef | grep "task-client-node" | awk '{print $2}' | xargs -L1 kill
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
sleep 1



