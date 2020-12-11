#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# This one is ugly
MASTER_IP_QUERY='.["_meta"].hostvars[.["kube-master"].hosts[0]].access_ip_v4'

MASTER_IP=$(inventory/$CLUSTER_NAME/hosts --list | jq --raw-output "$MASTER_IP_QUERY")

if [ -z "$MASTER_IP" ]; then
    read -r -p "What is the IP of your master? " MASTER_IP
fi

echo "Using MASTER_IP: $MASTER_IP"

ssh ubuntu@$MASTER_IP sudo cat /etc/kubernetes/cloud_config
