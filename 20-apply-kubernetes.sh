#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

ansible-playbook -i inventory/$CLUSTER_NAME/hosts --become --become-user=root kubespray/cluster.yml
