#!/bin/bash

function waitForElastticSearchStartup
{
  for (( ; ; ))
  do
    curl -silent localhost:9200/_cluster/state/version >/dev/null

    if [ $? -eq 0 ]; then
      break
    else
      echo Waiting for ElasticSearch to start up...
      sleep 5
    fi
  done
}


echo ''
echo Switching off shard re-allocation...
curl -XPUT localhost:9200/_cluster/settings -d '
{
    "transient" : {
        "cluster.routing.allocation.enable" : "none"
    }
}'

echo ''
echo Restarting ElasticSearch...
service elasticsearch stop
sleep 10
service elasticsearch start
waitForElastticSearchStartup

echo ''
echo Switching on shard re-allocation...
curl -XPUT localhost:9200/_cluster/settings -d '
{
    "transient" : {
        "cluster.routing.allocation.enable" : "all"
    }
}'

echo ''
echo Done.  ElasticSearch is now running.
