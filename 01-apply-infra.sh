#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}
: ${OS_USERNAME:?"Please set OS_USERNAME"}
: ${OS_PASSWORD:?"Please set OS_PASSWORD"}

# TODO: Remote state

TF_BASE_DIR=$(dirname $0)/inventory/$CLUSTER_NAME

export OS_AUTH_URL="https://keystone.api.cloud.ipnett.se/v3"
export OS_PROJECT_ID="add72b7b2ed644a8842b1784dbdf275f"
export OS_USER_DOMAIN_NAME="elastisys.se"
export OS_PROJECT_DOMAIN_NAME="elastisys.se"

# Nova does not like dot in certain places
export TF_VAR_cluster_name=$(echo $CLUSTER_NAME | tr '.' '_')

export TF_VAR_external_net="71b10496-2617-47ae-abbc-36239f0863bb" # public-v4
export TF_VAR_floatingip_pool="public-v4"
export TF_VAR_network_name=$TF_VAR_cluster_name # Would have been cool to have as default in upstream kubespray

# Elastisys Lomma and Elastisys HQ
export TF_VAR_k8s_allowed_remote_ips='["90.224.48.115", "194.132.164.168"]'

export TF_VAR_image="ubuntu-20.40-server-cloudimg-amd64-20200423"

export TF_VAR_flavor_k8s_master="1493be98-d150-4f69-8154-4d59ea49681c" # b.small
export TF_VAR_flavor_k8s_node="1493be98-d150-4f69-8154-4d59ea49681c" # b.small

export TF_VAR_az_list='["se-east-1"]'
export TF_VAR_az_list_node='["se-east-1"]'
export TF_VAR_number_of_bastions=0
export TF_VAR_number_of_k8s_masters=1
export TF_VAR_number_of_k8s_masters_no_etcd=0
export TF_VAR_number_of_etcd=0
export TF_VAR_number_of_k8s_masters_no_floating_ip=0
export TF_VAR_number_of_k8s_masters_no_floating_ip_no_etcd=0
export TF_VAR_number_of_k8s_nodes_no_floating_ip=0

pushd $TF_BASE_DIR
TF_DIR=../../kubespray/contrib/terraform/openstack
terraform init $TF_DIR
terraform validate $TF_DIR
terraform apply $TF_DIR # TODO: consider using -var-file=cluster.tfvars
popd
