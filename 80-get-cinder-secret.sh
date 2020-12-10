#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

kubectl \
    --context ${CLUSTER_NAME} \
    --namespace kube-system \
    get secret cloud-config \
    --output json \
| jq --raw-output '.data["cloud.conf"]' \
| base64 --decode
