#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# Avoid validating and admission webhooks from
# operating in the kube-system namespace. The Kubernetes cluster may work for a
# while, then system Pods won't restart unexpectedly, e.g., when masters are
# rebooted.
#
# https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#avoiding-operating-on-the-kube-system-namespace

kubectl \
    --context $CLUSTER_NAME \
    label namespace kube-system \
    control-plane="true" \
    --overwrite=true
