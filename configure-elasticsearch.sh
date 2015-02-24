#/bin/bash

function usage {
  echo
  echo Usage: sudo configure-elasticsearch CLUSTER_NAME HEAP_SIZE
  echo   e.g: sudo configure-elasticsearch elasticsearch-dev 1024m
  exit 1
}

export ES_CLUSTER_NAME=$1
export ES_HEAP_SIZE=$2

if [ "$(id -u)" != "0" ]; then
  echo "Please run this script with sudo"
  exit 1
fi

if [ "$ES_CLUSTER_NAME" = "" ] ; then
    echo "Specify the Elasticsearch cluster name"
    usage
fi

if [ "$ES_HEAP_SIZE" = "" ] ; then
    echo "Specify the Elasticsearch Java heap size.  e.g. 1024m"
    usage
fi


# Create elasticsearch config
echo 'Creating /etc/elasticsearch/elasticsearch.yml'

cat << EOF > /etc/elasticsearch/elasticsearch.yml

cluster.name: $ES_CLUSTER_NAME
cloud:
  aws:
    region: ap-southeast-2
  node.auto_attributes: true

discovery:
  type: ec2
  zen.ping.multicast.enabled: false
  zen.ping.timeout: 30s

network:
  publish_host: _ec2:publicDns_

repositories:
  s3:
    bucket: ingogo-backups
    base_path: elasticsearch/snapshots
    region: ap-southeast-2
EOF

# Create the header of the elasticsearch startup include to set environemnt variables
echo 'Creating /usr/share/elasticsearch/elasticsearch.in.sh'

cat << EOF > /usr/share/elasticsearch/elasticsearch.in.sh

#!/bin/bash
ES_CLUSTER_NAME=$ES_CLUSTER_NAME
ES_HEAP_SIZE=$ES_HEAP_SIZE
EOF

# Copy the remainder of elasticsearch startup include (but strip out the first line)
bash -c "sed -e '1d' /usr/share/elasticsearch/bin/elasticsearch.in.sh  >> /usr/share/elasticsearch/elasticsearch.in.sh"


# Configure elasticsearch service to run on startup:
echo 'Configuring Elasticsearch to run on startup'

/sbin/chkconfig --del elasticsearch
/sbin/chkconfig --add elasticsearch

cat << EOF

Configuration complete.  Run start-elasticsearch.sh or restart-elasticsearch.sh for the changes to take effect.

Install folder:
/usr/share/elasticsearch

Config folder:
/etc/elasticsearch

Logs folder:
/var/log/elasticsearch

Data folder:
/var/lib/elasticsearch
EOF
