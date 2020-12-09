#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}
: ${OS_USERNAME:?"Please set OS_USERNAME"}
: ${OS_PASSWORD:?"Please set OS_PASSWORD"}

# TODO: Remote state

TF_BASE_DIR=$(dirname $0)/inventory/$CLUSTER_NAME

pushd $TF_BASE_DIR
TF_DIR=../../kubespray/contrib/terraform/openstack
terraform destroy $TF_DIR # TODO: consider using -var-file=cluster.tfvars
popd