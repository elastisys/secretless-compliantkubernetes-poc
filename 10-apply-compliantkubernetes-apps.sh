#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

helm template \
    apps \
    apps \
| kubectl \
    apply \
    -f - \
    --dry-run=server \
    --context ${CLUSTER_NAME}

helm \
    --kube-context ${CLUSTER_NAME} \
    --namespace kube-system \
    upgrade \
    --install \
    apps \
    apps

echo
echo "NOTE: Don't forget to create an Elasticsearch secret in the next step."
