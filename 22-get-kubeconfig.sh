#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# This one is ugly
MASTER_IP_QUERY='.["_meta"].hostvars[.["kube-master"].hosts[0]].access_ip_v4'

MASTER_IP=$(inventory/$CLUSTER_NAME/hosts --list | jq --raw-output "$MASTER_IP_QUERY")

if [ -z "$MASTER_IP" ]; then
    read -r -p "What is the IP of your master? " MASTER_IP
fi

echo "Using MASTER_IP: $MASTER_IP"

ssh ubuntu@$MASTER_IP sudo cat /etc/kubernetes/admin.conf > ${CLUSTER_NAME}-admin.conf

yq r ${CLUSTER_NAME}-admin.conf clusters[0].cluster.certificate-authority-data | base64 -d > ${CLUSTER_NAME}-ca.pem
yq r ${CLUSTER_NAME}-admin.conf users[0].user.client-certificate-data | base64 -d > ${CLUSTER_NAME}-client-certificate.pem
yq r ${CLUSTER_NAME}-admin.conf users[0].user.client-key-data | base64 -d > ${CLUSTER_NAME}-client-key.pem

kubectl config set-cluster $CLUSTER_NAME \
    --server=https://$MASTER_IP:6443 \
    --certificate-authority=${CLUSTER_NAME}-ca.pem \
    --embed-certs

kubectl config set-credentials ${CLUSTER_NAME}-admin \
    --certificate-authority=${CLUSTER_NAME}-ca.pem \
    --client-key=${CLUSTER_NAME}-client-key.pem \
    --client-certificate=${CLUSTER_NAME}-client-certificate.pem \
    --embed-certs

kubectl config set-context $CLUSTER_NAME \
    --cluster=$CLUSTER_NAME \
    --user=${CLUSTER_NAME}-admin

kubectl config use-context $CLUSTER_NAME

rm -f ${CLUSTER_NAME}-*.conf ${CLUSTER_NAME}-*.pem
