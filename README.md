ec2-install-elasticsearch
=========================

Automatically install and configure Elasticsearch on EC2

Usage
-----

#### Install git on your ec2 instance
```
sudo yum install -y git
```
   
####  Clone this repository 
```
https://github.com/brainesy/ec2-install-elasticsearch.git
```

####  Install Elasticsearch
```
sudo install-elasticsearch.sh
```

####  Configure Elasticsearch
```
sudo configure-elasticsearch.sh [CLUSTER_NAME]  [JAVA_HEAP_SIZE]
```
e.g. 
```
sudo configure-elasticsearch.sh my-elasticsearch-cluster  1024m
```

Elasticsearch will now be running on your instance.  Repeat this process for each node in the cluster.
