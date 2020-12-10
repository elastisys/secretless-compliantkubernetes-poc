#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

if [ -z "$ELASTICSEARCH_PASSWORD" ]; then
    read -r -p "Elasticsearch password (not echoed): " -s ELASTICSEARCH_PASSWORD
fi

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  namespace: kube-system
  name: elasticsearch-password
  labels:
    app: fire-and-forget-secrets
    controlled-by: $(basename $0)
stringData:
  password: $ELASTICSEARCH_PASSWORD
EOF

echo
echo "Deleting old Fluentd Pods to force reconfiguration."
echo
kubectl \
    --context ${CLUSTER_NAME} \
    --namespace kube-system \
    --selector=app.kubernetes.io/name=fluentd-elasticsearch \
    --wait=false \
    delete \
    pods

echo
echo "Fluentd Pods should respawn shorty. Press CTRL+C when done."
echo
kubectl \
    --context ${CLUSTER_NAME} \
    --namespace kube-system \
    --selector=app.kubernetes.io/name=fluentd-elasticsearch \
    get \
    pods \
    --watch
