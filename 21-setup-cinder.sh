#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

# We force the user to use CINDER_* variables to remind them that these should
# point to a service account and not to the operator's credentials.
: ${CINDER_OS_USERNAME:?"Please set CINDER_OS_USERNAME"}
: ${CINDER_OS_PASSWORD:?"Please set CINDER_OS_PASSWORD"}

export OS_USERNAME=$CINDER_OS_USERNAME
export OS_PASSWORD=$CINDER_OS_PASSWORD

ansible-playbook \
    -i inventory/$CLUSTER_NAME/hosts \
    --become \
    --become-user=root \
    -e cinder_csi_enabled=1 \
    -e cinder_blockstorage_version=v2 \
    -t cinder-csi-driver \
    kubespray/cluster.yml

echo
echo "Consider rebooting CSI Cinder:"
echo "    kubectl --context ${CLUSTER_NAME} --namespace kube-system delete pods -l app=csi-cinder-controllerplugin"
echo "    kubectl --context ${CLUSTER_NAME} --namespace kube-system delete pods -l app=csi-cinder-nodeplugin"
