#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

kubectl delete secret \
    --namespace kube-system \
    --selector app=fire-and-forget-secrets
