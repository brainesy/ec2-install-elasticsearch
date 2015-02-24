function waitForElastticSearchStartup
{

  for (( ; ; ))
  do
    curl -silent ec2-54-66-220-194.ap-southeast-2.compute.amazonaws.com:9200/_cluster/state/version >/dev/null

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
