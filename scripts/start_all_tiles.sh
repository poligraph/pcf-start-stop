#!/bin/bash 

PASSWORD="password"
echo -e "director\n{PASSWORD}" | bosh2 login -e 10.0.0.10 --ca-cert /var/tempest/workspaces/default/root_ca_certificate


declare -a deployments=(`bosh2 deployments -e 10.0.0.10 --ca-cert /var/tempest/workspaces/default/root_ca_certificate --column=Name| grep -`)

for name in "${deployments[@]}"

do
  echo "starting ${name}"
  yes | bosh2 -e 10.0.0.10 --ca-cert /var/tempest/workspaces/default/root_ca_certificate -d ${name} start
done

