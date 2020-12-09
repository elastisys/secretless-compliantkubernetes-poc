#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Please source me." 2>&1
    echo "Usage: . ${BASH_SOURCE[0]}" 2>&1
    exit 1
fi

export CLUSTER_NAME=ck-secretless
