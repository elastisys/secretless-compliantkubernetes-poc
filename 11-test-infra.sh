#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

if [ -z "$ANSIBLE_HOST_KEY_CHECKING" ]; then
    echo "NOTE: Consider running this script as:" 2>&1
    echo "    ANSIBLE_HOST_KEY_CHECKING=False $0" 2>&1
    echo "" 2>&1
fi

ansible -i inventory/$CLUSTER_NAME/hosts -m ping all
