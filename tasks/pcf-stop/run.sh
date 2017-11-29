#!/usr/bin/dumb-init /bin/bash

set -o errexit
set -o nounset
set -o pipefail

ROOT_DIR=$(pwd)

HOST=$(echo ${PCF_URL} | awk -F/ '{print $3}')

mkdir -p ~/.ssh
echo "$OPS_SSH_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keyscan ${HOST} >> ~/.ssh/known_hosts
ssh -i ~/.ssh/id_rsa ubuntu@$HOST "/home/ubuntu/bin/stop_all_tiles.sh"
