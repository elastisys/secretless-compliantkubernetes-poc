#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# These two are required for the in-tree cloud provider :(
: ${OS_USERNAME:?"Please set OS_USERNAME"}
: ${OS_PASSWORD:?"Please set OS_PASSWORD"}

ansible-playbook \
    -i inventory/$CLUSTER_NAME/hosts \
    --become \
    --become-user=root \
    -e cloud_provider=openstack \
    kubespray/cluster.yml
