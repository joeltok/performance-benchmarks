cd ../
docker build . -t camunda-benchmarker
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
rm experiment-results/*
cd experiment-agent

docker run -d -p 3500:8080 camunda-benchmarker
sleep 5
curl http://localhost:3500 &> /dev/null # only returns when camunda platform is ready
echo Camunda Platform docker container running
node runner.js  "basic-java-class" 1 1000 6
runninginstance=$(docker ps | grep camunda-benchmarker | awk '{print $1;}')
docker stop $runninginstance
