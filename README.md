# Secretless Compliant Kubernetes PoC

This repo demonstrates how to set up and operate a Kubernetes cluster without storing secrets -- not even encrypted -- in the repository, while at the same time capturing all operating knowledge as code.

Currently, this repo deploys a small Kubernetes cluster on SafeSpring which Fluentd redirecting logs to a pre-set Elasticsearch host.

## Pre-requisites

Misc:

* [bash](https://www.gnu.org/software/bash/) >4
* [git](https://git-scm.com/downloads)
* [jq](https://stedolan.github.io/jq/)

Infrastructure setup:

* [Terraform](https://terraform.io) >0.13
* Pre-configured [SSH keys](https://www.ssh.com/ssh/keygen/)
* SafeSpring credentials in `OS_USERNAME` and `OS_PASSWORD`

Kubernetes setup:

* [Ansible](https://docs.ansible.com/) >2.9
* [Python netaddr](https://pypi.org/project/netaddr/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) >1.18

Kubernetes apps setup:

* [helm](https://helm.sh/docs/intro/install/) >3.2

## Usage

Start with:

    git clone --recursive git@github.com:elastisys/secretless-compliantkubernetes-poc

The repo is logically split in the following phases:

0. Configuration
1. Infrastructure Setup
2. Kubernetes Setup
3. Kubernetes Apps Setup
8. Disaster Recovery
9. Teardown

Each phase is encoded via a `${PHASE_ID}*.sh` script. For example, configuration is encoded in `00-source-config.sh`.

You are supposed to execute each script one after another, sorted by name. Follow the instructions of each script.
