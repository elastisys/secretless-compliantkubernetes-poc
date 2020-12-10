#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# We force the user to use CINDER_* variables to remind them that these should
# point to a service account and not to the operator's credentials.
: ${CINDER_OS_USERNAME:?"Please set CINDER_OS_USERNAME"}
: ${CINDER_OS_PASSWORD:?"Please set CINDER_OS_PASSWORD"}

export OS_AUTH_URL="https://keystone.api.cloud.ipnett.se/v3"
export OS_PROJECT_ID="add72b7b2ed644a8842b1784dbdf275f"
export OS_USER_DOMAIN_NAME="elastisys.se"
export OS_PROJECT_DOMAIN_NAME="elastisys.se"
export OS_REGION_NAME=se-east-1
export OS_USERNAME=CINDER_OS_USERNAME
export OS_PASSWORD=CINDER_OS_PASSWORD

ansible-playbook \
    -i inventory/$CLUSTER_NAME/hosts \
    --become \
    --become-user=root \
    -e cinder_csi_enabled=1 \
    -t cinder-csi-driver \
    kubespray/cluster.yml
