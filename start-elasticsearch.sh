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

service elasticsearch start
waitForElastticSearchStartup
