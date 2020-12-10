#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

helm \
    --kube-context ${CLUSTER_NAME} \
    --namespace kube-system \
    uninstall \
    apps
