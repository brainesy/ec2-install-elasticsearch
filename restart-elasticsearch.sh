#!/bin/bash
set -e


echo Switching off shard re-allocation...
curl -XPUT localhost:9200/_cluster/settings -d '
{
    "transient" : {
        "cluster.routing.allocation.enable" : "none"
    }
}'

echo Restarting ElasticSearch...
service elasticsearch restart

echo Switching on shard re-allocation...
curl -XPUT localhost:9200/_cluster/settings -d '
{
    "transient" : {
        "cluster.routing.allocation.enable" : "all"
    }

