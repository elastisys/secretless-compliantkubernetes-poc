#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

kubectl \
    --context ${CLUSTER_NAME} \
    --namespace kube-system \
    get secret elasticsearch-password \
    --output json \
| jq --raw-output '.data["password"]' \
| base64 --decode
