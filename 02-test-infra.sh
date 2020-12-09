#!/bin/bash

set -e

: ${CLUSTER_NAME:?"Please set CLUSTER_NAME"}

ansible -i inventory/$CLUSTER_NAME/hosts -m ping all
