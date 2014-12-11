#/bin/bash

export ES_PKG_NAME=elasticsearch-1.4.1
export ES_EC2_CLOUD_PLUGIN_VERSION=2.4.1

if [ "$(id -u)" != "0" ]; then
  echo "Please run this script with sudo"
  exit 1
fi

yum update -y

# Download the rpm
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.noarch.rpm

# Install the rpm
rpm -i $ES_PKG_NAME.noarch.rpm
rm $ES_PKG_NAME.noarch.rpm

# Install plugins:
cd /usr/share/elasticsearch
bin/plugin -install elasticsearch/elasticsearch-cloud-aws/$ES_EC2_CLOUD_PLUGIN_VERSION
bin/plugin -install mobz/elasticsearch-head
bin/plugin -install lukas-vlcek/bigdesk
bin/plugin -install royrusso/elasticsearch-HQ
# bin/plugin -install elasticsearch/marvel/latest

echo 'Installation complete.'
echo
echo 'Run configure-elasticsearch.sh to configure the cluster'

