ec2-install-elasticsearch
=========================

Automatically install and configure Elasticsearch on EC2

Usage
-----

1. Clone this repository onto a new EC2 instance
2. run 'sudo install-elasticsearch.sh'
3. run 'sudo configure-elasticsearch.sh [CLUSTER_NAME]  [JAVA_HEAP_SIZE]'

   e.g. ```sudo configure-elasticsearch.sh my-elasticsearch-cluster  1024m```

Elasticsearch will now be running on your instance.  Repeat this process for each node in the cluster.
