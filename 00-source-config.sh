#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Please source me." 2>&1
    echo "Usage: . ${BASH_SOURCE[0]}" 2>&1
    exit 1
fi

export CLUSTER_NAME=ck-secretless

export OS_AUTH_URL="https://keystone.api.cloud.ipnett.se/v3"
export OS_PROJECT_ID="add72b7b2ed644a8842b1784dbdf275f"
export OS_USER_DOMAIN_NAME="elastisys.se"
export OS_PROJECT_DOMAIN_NAME="elastisys.se"
export OS_REGION_NAME=se-east-1
